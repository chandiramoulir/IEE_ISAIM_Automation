*** Settings ***
Library  DatabaseLibrary

*** Variables ***
${oracleUsername}    sym82
${oraclePassword}    sym82
${oracleDbHost}    ral-iee-ora4.itronhdc.com
${oracleDbPort}    1521
${oracleDatabaseName}    pdbora4.itronhdc.com


*** Keywords ***

Verify in DB
    [ARGUMENTS]  ${Meter_ID}
    Log    ${Meter_ID}
    #sleep  15 Seconds
    Check If Exists In Database     SELECT * FROM METER WHERE METERID = '${Meter_ID}'
#    ${QueryResult}  Query   SELECT METERNUMBER, METERID FROM METER WHERE METERID = '${Meter_ID}'
#    Log Many  @{QueryResult}
    #Log  ${Query_SQl}
