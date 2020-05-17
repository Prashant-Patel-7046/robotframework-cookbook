# This code will read Data from ALL rows and columns of a Database table and stores them into a List Variable.
# To Run: Replace three variables values under Variable section.
# Author: Prashant Patel
# Creation Date: 5/13/2020
#######################################################################

*** Settings ***
Library  DatabaseLibrary
Library  SeleniumLibrary

*** Variables ***
${DatabaseUsername} =    dbUser
${DatabasePassword} =    dbPwd
${DatabaseHostname} =    dbHost
${DatabasePort} =        dbPort
${DatabaseService} =     dbService
${SqlQuery} =            select * from TableName

*** Keywords ***
Retrieve Data From Database Table
    ${DatabaseConnectionString} =  Set Variable  '${DatabaseUsername}','${DatabasePassword}','${DatabaseHostname}:${DatabasePort}/${DatabaseService}'
    Connect to Database Using Custom Params    cx_Oracle    ${DatabaseConnectionString}
    # Stores Sql Qury results to a List variable
    @{DataFromDatabaseTable}    Query    ${SqlQuery}
    Disconnect From Database
    [Return]    @{DataFromDatabaseTable}

*** Test Cases ***
Print Data From Database Table
    ${DataDic} =    Retrieve Data From Database Table
    FOR    ${element}    IN    ${DataDic}
        Log To Console    ${element}
    END
