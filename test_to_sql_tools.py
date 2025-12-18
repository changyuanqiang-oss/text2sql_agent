from langchain_core.tools import BaseTool
from pydantic import BaseModel, Field
from typing import Type, Optional, List, Dict, Any
import re
from src1.db_utils import MySQLDatabaseManager

class ListTablesTool(BaseTool):
    name: str = "ListTablesTool"
    description: str = "列出mysql数据库中的所有表名及其描述信息。当需要了解数据库中有哪些表以及表的用途时使用此工具。"
    db_manager: MySQLDatabaseManager  # 明确定义字段

    def __init__(self, db_manager: MySQLDatabaseManager):
        # 通过基类初始化字段
        super().__init__(db_manager=db_manager)

    def _run(self) -> str:
        try:
            tables_info = self.db_manager.get_tables_with_comments()
            if not tables_info:
                return "数据库中未找到任何表"
            result = "数据库中的表列表：\n"
            for i, table_info in enumerate(tables_info, 1):
                result += f"{i}. {table_info['table_name']}: {table_info['table_comment']}\n"
            return result
        except Exception as e:
            return f"获取表列表时出错：{str(e)}"

    async def _arun(self) -> str:
        return self._run()


class TableSchemaInput(BaseModel):
    table_name: str = Field(description="要获取结构的表名，多个表名用逗号分隔")
    include_comments: Optional[bool] = Field(default=True, description="是否包含列注释信息")


class TableSchemaTool(BaseTool):
    name: str = "TableSchemaTool"
    description: str = "获取mysql数据库中指定表的详细模式信息，包括列定义，主键，外键等。"
    args_schema: Type[BaseModel] = TableSchemaInput
    db_manager: MySQLDatabaseManager  # 明确定义字段

    def __init__(self, db_manager: MySQLDatabaseManager):
        super().__init__(db_manager=db_manager)

    def _run(self, table_name: str, include_comments: bool = True) -> str:
        try:
            table_names = [name.strip() for name in table_name.split(',') if name.strip()]
            if not table_names:
                return "请提供有效的表名"
            all_tables = self.db_manager.get_table_names()
            invalid_tables = [name for name in table_names if name not in all_tables]
            if invalid_tables:
                return f"以下表不存在：{', '.join(invalid_tables)}"
            schema_info = self.db_manager.get_table_schema(table_names)
            return schema_info
        except Exception as e:
            return f"获取表结构时出错：{str(e)}"

    async def _arun(self, table_name: str, include_comments: bool = True) -> str:
        return self._run(table_name, include_comments)


class SQLQueryInput(BaseModel):
    query: str = Field(description="要执行的SQL SELECT查询语句")


class SQLQueryTool(BaseTool):
    name: str = "SQLQueryTool"
    description: str = "在MySQL数据库上执行安全的SELECT查询并返回结果。输入应为有效的SQL SELECT查询语句。"
    args_schema: Type[BaseModel] = SQLQueryInput
    db_manager: MySQLDatabaseManager  # 明确定义字段

    def __init__(self, db_manager: MySQLDatabaseManager):
        super().__init__(db_manager=db_manager)

    def _run(self, query: str) -> str:
        try:
            if self._contains_sql_injection(query):
                return "查询包含潜在的安全风险，已被拒绝执行"
            validation_result = self.db_manager.validate_sql_syntax(query, validate_security=True)
            if not validation_result['is_safe']:
                return f"查询不安全，拒绝执行。安全违规：{validation_result.get('security_violations', [])}"
            if not validation_result['is_valid']:
                return f"SQL语法错误：{validation_result.get('syntax_error', '未知错误')}"
            result = self.db_manager.execute_query(query)
            return result
        except Exception as e:
            return f"执行查询时出错：{str(e)}"

    def _contains_sql_injection(self, query: str) -> bool:
        suspicious_patterns = [
            r';.*--',
            r'\b(union|union all)\b.*\bselect\b',
            r'\b(drop|alter|create|truncate)\b',
            r'\b(insert|update|delete)\b',
            r'\b(grant|revoke|deny)\b',
            r'\b(exec|execute|xp_cmdshell)\b',
        ]
        query_lower = query.lower()
        for pattern in suspicious_patterns:
            if re.search(pattern, query_lower, re.IGNORECASE):
                return True
        return False

    async def _arun(self, query: str) -> str:
        return self._run(query)


class SQLQueryCheckerInput(BaseModel):
    query: str = Field(description="要检查的SQL查询语句")
    validate_security: Optional[bool] = Field(default=True, description="是否进行安全检查")
    validate_schema: Optional[bool] = Field(default=False, description="是否验证表和列是否存在")


class SQLQueryCheckerTool(BaseTool):
    name: str = "SQLQueryCheckerTool"
    description: str = "检查SQL查询语句的语法是否正确,提供验证反馈。输入应为要检查的SQL查询。"
    args_schema: Type[BaseModel] = SQLQueryCheckerInput
    db_manager: MySQLDatabaseManager  # 明确定义字段

    def __init__(self, db_manager: MySQLDatabaseManager):
        super().__init__(db_manager=db_manager)

    def _run(self, query: str, validate_security: bool = True, validate_schema: bool = False) -> str:
        try:
            validation_result = self.db_manager.validate_sql_syntax(
                query, validate_security=validate_security, validate_schema=validate_schema
            )
            result = "SQL查询验证结果：\n"
            result += f"✓ 语法有效性: {'有效' if validation_result['is_valid'] else '无效'}\n"
            result += f"✓ 安全性: {'安全' if validation_result['is_safe'] else '不安全'}\n"
            if validation_result['syntax_error']:
                result += f"✗ 语法错误: {validation_result['syntax_error']}\n"
            if validation_result['security_violations']:
                result += f"✗ 安全违规: {', '.join(validation_result['security_violations'])}\n"
            if validation_result['table_references']:
                result += f"✓ 引用的表: {', '.join(validation_result['table_references'])}\n"
            result += f"✓ 验证消息: {validation_result['message']}"
            return result
        except Exception as e:
            return f"检查SQL语法时出错：{str(e)}"

    async def _arun(self, query: str, validate_security: bool = True, validate_schema: bool = False) -> str:
        return self._run(query, validate_security, validate_schema)


class DatabaseToolsFactory:
    def __init__(self, connection_string: str):
        self.db_manager = MySQLDatabaseManager(connection_string)

    def create_all_tools(self) -> List[BaseTool]:
        return [
            ListTablesTool(db_manager=self.db_manager),
            TableSchemaTool(db_manager=self.db_manager),
            SQLQueryTool(db_manager=self.db_manager),
            SQLQueryCheckerTool(db_manager=self.db_manager)
        ]

    def get_tool_by_name(self, tool_name: str) -> Optional[BaseTool]:
            """根据工具名获取特定工具"""
            tools = self.create_all_tools()
            for tool in tools:
                if tool.name == tool_name:
                    return tool
            return None

# 使用示例
if __name__ == "__main__":
    # 数据库配置
    DB_CONFIG = {
        "host": "localhost",
        "username": "root",
        "password": "root",
        "database": "book",
        "port": 3306,
    }

    connection_string = (
        f"mysql+pymysql://{DB_CONFIG['username']}:{DB_CONFIG['password']}"
        f"@{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}"
    )

    # 创建工具工厂
    tools_factory = DatabaseToolsFactory(connection_string)

    # 获取所有工具
    tools = tools_factory.create_all_tools()

    print("=== 数据库工具创建成功 ===")
    for i, tool in enumerate(tools, 1):
        print(f"{i}. {tool.name}: {tool.description}")

    # 测试各个工具
    print("\n=== 工具测试 ===")

    # 测试 ListTablesTool
    list_tool = tools_factory.get_tool_by_name("ListTablesTool")
    if list_tool:
        print("1. 测试表列表工具:")
        result = list_tool._run()
        print(result[:500] + "..." if len(result) > 500 else result)  # 限制输出长度

    # 测试 TableSchemaTool
    schema_tool = tools_factory.get_tool_by_name("TableSchemaTool")
    if schema_tool:
        print("\n2. 测试表结构工具:")
        # 获取一个表名来测试
        try:
            tables = tools_factory.db_manager.get_tables_with_comments()
            if tables:
                sample_table = tables[0]['table_name']
                result = schema_tool._run(table_name=sample_table)
                print(result[:1000] + "..." if len(result) > 1000 else result)
        except Exception as e:
            print(f"表结构测试失败: {e}")

    # 测试 SQLQueryCheckerTool
    checker_tool = tools_factory.get_tool_by_name("SQLQueryCheckerTool")
    if checker_tool:
        print("\n3. 测试SQL检查工具:")
        test_queries = [
            "SELECT * FROM INFORMATION_SCHEMA.TABLES",
            "SELECT FROM WHERE",  # 错误的查询
            "DROP TABLE users"  # 不安全的查询
        ]

        for query in test_queries:
            print(f"检查查询: {query}")
            result = checker_tool._run(query=query)
            print(result)
            print("-" * 50)

    print("\n所有工具创建完成，可以集成到LangChain Agent中使用！")