import xlrd
import string

def Read_Entire_Excel_Using_Xlrd(FileName, WorksheetName):
    
    workbook = xlrd.open_workbook(FileName, on_demand = True)
    worksheet = workbook.sheet_by_name(WorksheetName)
    
    # Stores the columns name from the first row to a list of dictionay
    FirstRowDic = []
    for ColIndex in range(worksheet.ncols):
        FirstRowDic.append(worksheet.cell_value(0,ColIndex))
    
    # Stores Cell's Data to a list of dictionay
    DataFromExcel = []
    for RowIndex in range(1, worksheet.nrows):
        ColumnDic = {}
        for ColIndex in range(worksheet.ncols):
            ColumnDic[FirstRowDic[ColIndex]]=worksheet.cell_value(RowIndex,ColIndex)
        
        DataFromExcel.append(ColumnDic)
    return DataFromExcel
