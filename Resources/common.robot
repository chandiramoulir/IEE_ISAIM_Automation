*** Settings ***
Library  DatabaseLibrary
*** Variables ***
${Port}           1433
${Username}       sa
${DatabaseHost}    RAL-REDWOOD-DB1.ITRONHDC.COM
${Password}       Meterguy1
@{QueryResult}
${RowCount}       ${EMPTY}

*** Test Cases ***
DATABASE-CONNECT CHECK
    Connect to Database    pymssql    ARTPILOT    ${Username}    ${Password}    ${DatabaseHost}    ${Port}
    #Check If Exists In Database  select * from SoftwareInstallation where InstallationVersion='8.2.6.345'
    @{QueryResult}  Query   select * from SoftwareInstallation where InstallationVersion='8.2.6.345'
    Log  @{QueryResult}
    Disconnect From Database

*** Keywords ***
