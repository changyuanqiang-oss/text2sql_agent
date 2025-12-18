from langchain.agents import create_agent
from langchain_core.prompts import ChatPromptTemplate
from langchain_openai import ChatOpenAI
import dotenv
import re
from langgraph.checkpoint.memory import InMemorySaver
from src.test_to_sql_tools import DatabaseToolsFactory
dotenv.load_dotenv()

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

llm = ChatOpenAI(temperature=0,
                 model="qwen3-80b" ,
                 )

# 创建数据库工具
tools_factory = DatabaseToolsFactory(connection_string)
database_tools = tools_factory.create_all_tools()

# 创建Agent
agent = create_agent(
    tools=database_tools,
    model=llm,
    checkpointer=InMemorySaver(),
    system_prompt="你是一名数据分析师，请回答用户的问题",
)
config = {"configurable": {"thread_id": "1"}}

prompt1 = """
你现在是一名专业的数据分析师，任务是根据用户的数据查询需求，从提供的数据集中提取并整理对应的结果。

首先，请阅读用户的数据查询需求：
<data_request>
四个区域负责人所在的区域销售额，利润，订单数，分别是多少？
</data_request>

提示信息：


在处理查询时，请遵循以下规则：
- 严格从数据集中提取信息，不得添加数据集外的内容或主观推测
- 若数据集中包含多组相关数据，请完整列出所有匹配结果
- 若数据集中没有用户查询的内容，请明确说明“未查询到对应数据”
- 输出结果需清晰标注数据对应的维度（如时间、类别等），确保数据含义明确
- 最后的结果以json格式返回

首先，在<思考>标签中说明你如何理解查询需求、如何从数据集中定位数据（包括数据所在的位置或筛选条件）；然后在<result>标签中输出整理后的最终数据。

<思考>
[在此说明
- 对查询需求的理解；\n
- 数据定位的过程与依据；\n
- 用到的所有sql查询语句；\n]
</思考>
<result>
[在此输出从数据集中提取的最终结果，格式清晰、数据准确]
</result>

"""
prompt = """
你现在是一名专业的数据分析师，任务是根据用户的数据查询需求，从提供的数据集中提取并整理对应的结果。

首先，请阅读用户的数据查询需求：
<data_request>
四个区域负责人所在的区域销售额，利润，订单数，分别是多少？
</data_request>

在处理查询时，请遵循以下规则：
- 不要输出标题，只输出数据
- 严格从数据集中提取信息，不得添加数据集外的内容或主观推测
- 若数据集中包含多组相关数据，请完整列出所有匹配结果
- 若数据集中没有用户查询的内容，请明确说明“未查询到对应数据”
- 输出结果需清晰标注数据对应的维度（如时间、类别等），确保数据含义明确
- 最后的结果以json格式返回
"""
# response = agent.invoke({"input": prompt})
# response = agent.invoke({"query": query})
response = agent.invoke({"role": "user", "messages": prompt},config)
result = response["messages"][-1].content
print(result)

