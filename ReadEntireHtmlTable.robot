*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  String

*** Variables ***
${Table_Row_Locator} =    //*[@id="npac-error-message-box-table"]/tbody[2]/tr
${Table_Col_Locator} =    //*[@id="npac-error-message-box-table"]/tbody[2]/tr[1]/td
${Table_Locator} =        //*[@id="npac-error-message-box-table"]

*** Keywords ***
Get All Row And Column Values Of A Html Table
    # Get row count
    ${TotalRow} =  Get Element Count  ${Table_Row_Locator}
    # Create a list
    @{RowValueList}    Create List
    # Initialize the list index to zero
    ${ListIndex} =    Set Variable    0
    # Start reading from 2 second row because first row has column headings
    FOR    ${CurrentRowIndex}    IN RANGE    2    ${TotalRow}+2
            Process Row And Create A List    ${CurrentRowIndex}    ${ListIndex}    @{RowValueList}
    END

Process Row And Create A List
    [Arguments]    ${CurrentRowIndex}    ${ListIndex}    @{RowValueList}
    # Get Column Count
    ${TotalColumn} =  Get Element Count  ${Table_Col_Locator}
    FOR    ${CurrentColIndex}    IN RANGE    1    ${TotalColumn}+1
        # Get value from the row
        ${RowValue}    Get Table Cell    ${Table_Locator}    ${CurrentRowIndex}    ${CurrentColIndex}
        # Insert into List
        Insert Into List    ${RowValueList}    ${ListIndex}    ${RowValue}
        # Incremeant the list index by 1
        ${Cnt} =  Evaluate    ${ListIndex} + 1
    END
    Set Suite Variable    ${RowValueList}


*** Test Cases ***
Print The List
    ${LengthOfList}=    Get Length    ${RowValueList}
    FOR    ${index}    IN RANGE    ${LengthOfList}
        Log    ${RowValueList[${index}]}
    END
