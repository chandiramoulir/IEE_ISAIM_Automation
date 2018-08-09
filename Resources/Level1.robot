*** Settings ***
Documentation    Suite description
Resource    ../Resources/Level2.robot
Resource    ../Resources/db_connect.robot

*** Variables ***
${Meter_ID}=        set global variable

*** Keywords ***

Call Meter Create
    ${Meter_Id}     Meter Create
    Wait Until Keyword Succeeds     2 min       5 sec       Verify in DB        ${Meter_ID}

Call Register Create
    Register Create

Call Meter Location
    Meter Location