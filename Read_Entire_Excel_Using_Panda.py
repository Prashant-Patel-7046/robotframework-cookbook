  
import pandas as pd
from pandas import *

def Read_Entire_Excel_Using_Panda(FileName, WorksheetName):
    df = pd.read_excel(FileName, WorksheetName)
    DataFromExcel = df.to_dict()
    return DataFromExcel
 
