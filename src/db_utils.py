from sqlalchemy import create_engine, inspect, text
from sqlalchemy.exc import SQLAlchemyError, ProgrammingError, OperationalError
from loguru import logger
from typing import List, Union, Optional, Tuple, Dict, Any
import re


class MySQLDatabaseManager:
    """MySQL数据库管理器，负责数据库连接和基本操作"""

    def __init__(self, connection_string):
        """初始化MySQL数据库连接

        Args:
            connection_string: MySQL连接字符串,格式为:
            mysql+pymysql://username:password@host:port/database
        """
        self.connection_string = connection_string
        self.engine = create_engine(
            self.connection_string,
            pool_recycle=3600,
            pool_size=5,
            max_overflow=10
        )

    def get_table_names(self):
        """获取数据库中所有的表名"""
        try:
            inspector = inspect(self.engine)
            return inspector.get_table_names()
        except SQLAlchemyError as e:
            logger.error(f"获取表名失败：{str(e)}")
            raise ValueError(f"获取表名失败：{str(e)}")

    def get_tables_with_comments(self) -> List[dict]:
        """获取表名和表注释信息"""
        try:
            query = text("""
                SELECT TABLE_NAME, TABLE_COMMENT 
                FROM INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = DATABASE()
                AND TABLE_TYPE = 'BASE TABLE'
                ORDER BY TABLE_NAME
            """)
            with self.engine.connect() as connection:
                result = connection.execute(query)
                tables_info = [
                    {'table_name': row[0], 'table_comment': row[1] or '无注释'}
                    for row in result
                ]
                return tables_info
        except SQLAlchemyError as e:
            logger.error(f"获取表名及描述信息失败：{str(e)}")
            raise ValueError(f"获取表名及描述信息失败：{str(e)}")

    def get_table_schema(self, table_names: Optional[List[str]] = None) -> str:
        """获取指定表的完整结构信息

        Args:
            table_names: 可选的表名列表，如果为None则获取所有表

        Returns:
            格式化后的表结构信息字符串
        """
        try:
            inspector = inspect(self.engine)
            schema_info = []
            tables_to_process = table_names if table_names else self.get_table_names()

            for table_name in tables_to_process:
                columns = inspector.get_columns(table_name)
                pk_constraint = inspector.get_pk_constraint(table_name) #主键约束
                primary_keys = pk_constraint['constrained_columns'] if pk_constraint else [] # 主键
                foreign_keys = inspector.get_foreign_keys(table_name) #外键
                indexes = inspector.get_indexes(table_name)

                table_schema = f"表名: {table_name}\n"
                table_schema += "列信息:\n"

                for column in columns:
                    pk_indicator = "(主键)" if column['name'] in primary_keys else ""
                    comment = column.get('comment', '无注释')
                    table_schema += f"  - {column['name']}: {str(column['type'])}{pk_indicator}, 注释: {comment}\n"

                if foreign_keys:
                    table_schema += "外键约束:\n"
                    for fk in foreign_keys:
                        table_schema += f"  - {fk['constrained_columns']} -> {fk['referred_table']}.{fk['referred_columns']}\n"

                if indexes:
                    table_schema += "索引信息:\n"
                    for idx in indexes:
                        if not idx.get('name', '').startswith('sqlite_'):
                            table_schema += f"  - {idx['name']}: {idx['column_names']} ({'唯一' if idx.get('unique') else '非唯一'})\n"

                schema_info.append(table_schema)
                schema_info.append("-" * 50)

            return "\n".join(schema_info) if schema_info else "未找到匹配的表"

        except SQLAlchemyError as e:
            logger.error(f"获取表模式失败：{str(e)}")
            raise ValueError(f"获取表模式失败：{str(e)}")

    def execute_query(self, query: str) -> str:
        """执行SQL查询并返回结果

        Args:
            query: SQL查询语句

        Returns:
            查询结果字符串

        Raises:
            ValueError: 如果查询包含敏感操作关键词
        """
        # 安全检查：防止数据修改操作
        forbidden_keywords = ['insert', 'update', 'delete', 'drop', 'alter', 'create', 'grant', 'truncate']
        query_lower = query.lower().strip()

        # 检查是否以SELECT或WITH开头（允许子查询等复杂情况）
        if not query_lower.startswith(('select', 'with')) and  any(
                keyword in query_lower for keyword in forbidden_keywords
        ):
            raise ValueError("出于安全考虑，只允许执行SELECT查询和WITH查询")

        try:
            with self.engine.connect() as connection:
                result = connection.execute(text(query))

                # 获取列名
                columns = result.keys()

                # 获取所有行
                rows = result.fetchall()

                # 将结果格式化为可读字符串
                if not rows:
                    return "查询结果为空"

                # 计算每列的最大宽度
                col_widths = [len(str(col)) for col in columns]
                for row in rows:
                    for i, value in enumerate(row):
                        col_widths[i] = max(col_widths[i], len(str(value or '')))

                # 构建表头分隔线
                separator_line = "+" + "+".join("-" * (width + 2) for width in col_widths) + "+"

                # 构建表头
                header = "|" + "|".join(f" {str(col).ljust(width)} " for col, width in zip(columns, col_widths)) + "|"

                # 构建数据行
                data_lines = []
                for row in rows:
                    data_line = "|" + "|".join(
                        f" {str(value or '').ljust(width)} " for value, width in zip(row, col_widths)) + "|"
                    data_lines.append(data_line)

                # 组合结果
                result_str = f"查询结果（共 {len(rows)} 行）：\n"
                result_str += separator_line + "\n"
                result_str += header + "\n"
                result_str += separator_line + "\n"
                result_str += "\n".join(data_lines) + "\n"
                result_str += separator_line

                return result_str

        except SQLAlchemyError as e:
            logger.error(f"执行查询失败：{str(e)}")
            raise ValueError(f"执行查询失败：{str(e)}")
        except Exception as e:
            logger.error(f"未知错误：{str(e)}")
            raise ValueError(f"查询执行时发生未知错误：{str(e)}")

    def validate_sql_syntax(self, query: str,
                            validate_security: bool = True,
                            validate_schema: bool = False) -> Dict[str, Any]:
        """验证SQL查询语法是否正确

        Args:
            query: SQL查询语句
            validate_security: 是否进行安全检查（默认True）
            validate_schema: 是否验证表/列是否存在（默认False）

        Returns:
            Dict[str, Any]: 包含验证结果的信息字典

        Example:
            {
                'is_valid': True/False,
                'is_safe': True/False,
                'syntax_error': '错误信息' 或 None,
                'table_references': ['table1', 'table2'],
                'column_references': ['column1', 'column2'],
                'security_violations': ['insert', 'update']
            }
        """
        result = {
            'is_valid': False,
            'is_safe': False,
            'syntax_error': None,
            'table_references': [],
            'column_references': [],
            'security_violations': [],
            'message': ''
        }

        # 1. 基本格式检查
        query_lower = query.lower().strip()
        if not query_lower:
            result['message'] = "查询语句不能为空"
            return result

        # 2. 安全检查
        if validate_security:
            security_check = self._check_query_security(query)
            if not security_check['is_safe']:
                result['security_violations'] = security_check['violations']
                result['message'] = security_check['message']
                return result
            result['is_safe'] = True
        else:
            result['is_safe'] = True  # 如果跳过安全检查，则认为是安全的

        # 3. 语法验证
        try:
            # 使用EXPLAIN来验证查询语法而不实际执行
            explain_query = f"EXPLAIN {query}"

            with self.engine.connect() as connection:
                # 尝试执行EXPLAIN，如果语法错误会抛出异常
                connection.execute(text(explain_query))

                # 如果没有异常，语法正确
                result['is_valid'] = True

                # 尝试提取表和列信息
                if validate_schema:
                    try:
                        # 提取表引用
                        tables = self._extract_table_references(query)
                        result['table_references'] = tables

                        # 验证表是否存在
                        if tables:
                            existing_tables = self.get_table_names()
                            non_existent = [t for t in tables if t not in existing_tables]
                            if non_existent:
                                result['syntax_error'] = f"以下表不存在: {', '.join(non_existent)}"
                                result['is_valid'] = False
                    except Exception as e:
                        # 如果提取失败，不影响主体验证结果
                        logger.warning(f"提取表和列信息时出错: {e}")

                result['message'] = "SQL语法验证通过"

        except ProgrammingError as e:
            # 语法错误
            error_msg = str(e)
            result['syntax_error'] = error_msg
            result['message'] = f"SQL语法错误: {error_msg}"

        except OperationalError as e:
            # 操作错误，如表不存在等
            error_msg = str(e)
            result['syntax_error'] = error_msg
            result['message'] = f"SQL操作错误: {error_msg}"

        except SQLAlchemyError as e:
            # 其他SQLAlchemy错误
            error_msg = str(e)
            result['syntax_error'] = error_msg
            result['message'] = f"SQL验证失败: {error_msg}"

        except Exception as e:
            # 未知错误
            error_msg = str(e)
            result['syntax_error'] = error_msg
            result['message'] = f"验证过程中发生未知错误: {error_msg}"

        return result

    def _check_query_security(self, query: str) -> Dict[str, Any]:
        """检查SQL查询的安全性

        Args:
            query: SQL查询语句

        Returns:
            Dict[str, Any]: 安全检查结果
        """
        query_lower = query.lower().strip()

        # 敏感操作关键词
        forbidden_keywords = ['insert', 'update', 'delete', 'drop',
                              'alter', 'create', 'grant', 'truncate',
                              'replace', 'rename', 'lock', 'unlock',
                              'set', 'commit', 'rollback', 'savepoint',
                              'exec', 'execute', 'call', 'prepare']

        # 检查是否以允许的关键词开头
        allowed_prefixes = ['select', 'with', 'show', 'describe', 'desc', 'explain']
        starts_with_allowed = any(query_lower.startswith(prefix) for prefix in allowed_prefixes)

        # 检查是否包含敏感关键词
        violations = [kw for kw in forbidden_keywords if kw in query_lower]

        # 特殊处理：如果以WITH开头，但包含危险操作
        if query_lower.startswith('with'):
            # 检查WITH子句中是否包含敏感操作
            pattern = r'with\s+[^(]+\s+as\s*\((.*?)\)\s*select'
            match = re.search(pattern, query_lower, re.IGNORECASE | re.DOTALL)
            if match:
                cte_body = match.group(1)
                cte_violations = [kw for kw in forbidden_keywords if kw in cte_body]
                violations.extend(cte_violations)

        is_safe = starts_with_allowed and not violations

        return {
            'is_safe': is_safe,
            'violations': violations,
            'message': f"查询{'安全' if is_safe else f'不安全，检测到违规操作: {violations}'}"
        }

    def _extract_table_references(self, query: str) -> List[str]:
        """从SQL查询中提取表引用

        Args:
            query: SQL查询语句

        Returns:
            List[str]: 表名列表
        """
        # 简化的表名提取（实际项目中可能需要更复杂的SQL解析）
        query_lower = query.lower()

        # 移除字符串常量
        query_no_strings = re.sub(r"'.*?'", "''", query_lower)

        # 查找FROM和JOIN后面的表名
        table_patterns = [
            r'from\s+(\w+)',
            r'join\s+(\w+)',
            r'update\s+(\w+)',  # 虽然不允许，但为了完整性
            r'into\s+(\w+)'  # INSERT INTO
        ]

        tables = set()
        for pattern in table_patterns:
            matches = re.findall(pattern, query_no_strings, re.IGNORECASE)
            tables.update(matches)

        # 移除可能的别名
        cleaned_tables = []
        for table in tables:
            # 移除表别名（如 FROM table1 t1）
            table_name = table.split()[0] if ' ' in table else table
            # 移除可能的数据库前缀（如 database.table）
            table_name = table_name.split('.')[-1]
            cleaned_tables.append(table_name)

        return list(set(cleaned_tables))  # 去重

    def __enter__(self):
        """支持上下文管理器"""
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """退出上下文时关闭引擎"""
        self.engine.dispose()


if __name__ == '__main__':
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

    with MySQLDatabaseManager(connection_string) as manager:
        print("=== SQL语法验证测试 ===")

        # 测试用例
        test_queries = [
            # 正确的查询
            "SELECT * FROM INFORMATION_SCHEMA.TABLES LIMIT 5",
            "SELECT TABLE_NAME, TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = DATABASE()",
            "WITH cte AS (SELECT 1 as id) SELECT * FROM cte",

            # 语法错误的查询
            "SELECT FROM WHERE",  # 缺少表和条件
            "SELECT * FROM non_existent_table",  # 表不存在
            "SELECT * FROM",  # 缺少表名

            # 不安全的查询
            "DROP TABLE users",
            "INSERT INTO test VALUES (1, 'test')",
            "UPDATE users SET name = 'test' WHERE id = 1",

            # 复杂查询
            "SELECT t1.*, t2.comment FROM INFORMATION_SCHEMA.TABLES t1 JOIN INFORMATION_SCHEMA.COLUMNS t2 ON t1.TABLE_NAME = t2.TABLE_NAME"
        ]

        for i, query in enumerate(test_queries, 1):
            print(f"\n[{i}] 测试查询: {query}")
            print("=" * 50)

            # 验证语法
            validation_result = manager.validate_sql_syntax(query, validate_security=True, validate_schema=False)

            # 输出结果
            print(f"语法是否有效: {validation_result['is_valid']}")
            print(f"是否安全: {validation_result['is_safe']}")
            if validation_result['syntax_error']:
                print(f"语法错误: {validation_result['syntax_error']}")
            if validation_result['security_violations']:
                print(f"安全违规: {validation_result['security_violations']}")
            if validation_result['table_references']:
                print(f"引用的表: {validation_result['table_references']}")
            print(f"消息: {validation_result['message']}")

            # 如果是安全且有效的查询，可以尝试执行
            if validation_result['is_safe'] and validation_result['is_valid']:
                try:
                    result = manager.execute_query(query)
                    print("查询执行成功")
                    if "查询结果" in result:
                        # 只显示前几行
                        lines = result.split('\n')
                        preview_lines = lines[:10]  # 显示前10行
                        print("\n".join(preview_lines))
                        if len(lines) > 10:
                            print("... (结果被截断)")
                except Exception as e:
                    print(f"执行时出错: {e}")

            print("-" * 50)