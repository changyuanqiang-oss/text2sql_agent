from langchain.tools import tool
import pandas as pd
import ydata_profiling as pp

@tool
def create_report(data):
    """
    根据传入的数据，自动生成数据分析报告
    :param data: List
    :return: ProfileReport
    """
    data  = pd.DataFrame(data)
    report = pp.ProfileReport(data)

    return report,report.to_file("./src/数据分析报告.html")