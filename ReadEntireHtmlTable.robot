*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  String

*** Keywords ***
Get All Row And Column Values Of A Html Table
    # Get row count
    ${TotalRow} =  Get Element Count  //*[@id="Table Locator"]/tbody[4]/tr
    # Create a list
    @{RowValueList}    Create List
    # Initialize the list index to zero
    ${ListIndex} =    Set Variable    0
    FOR    ${CurrentRowIndex}    IN RANGE    1    ${TotalRow}+1
            Process Row And Create A List    ${CurrentRowIndex}    ${ListIndex}    @{RowValueList}
    END
    
Process Row And Create A List
    [Arguments]    ${CurrentRowIndex}    ${ListIndex}    @{RowValueList}
    # Get Column Count
    ${TotalColumn} =  Get Element Count  //*[@id="Table Locator"]/tbody[4]/tr[1]/td
    FOR    ${CurrentColIndex}    IN RANGE    1    ${TotalColumn}+1
        # Get value from the row
        ${RowValue}    Get Table Cell    //*[@id="Table Locator"]    ${CurrentRowIndex}    ${CurrentColIndex}
        # Insert into List
        Insert Into List    ${RowValueList}    ${ListIndex}    ${RowValue}
        # Incremeant the list index by 1
        ${Cnt} =  Evaluate    ${ListIndex} + 1
    END
    Set Suite Variable    ${RowValueList}
    
*** Test Cases ***
Test Case 1
    Get All Row And Column Values Of A Html Table
    Log List    @{RowValueList}
    
