*** Settings ***
Documentation    Suite description
Resource    ../Resources/Level2.robot
Resource    ../Resources/db_connect.robot

*** Variables ***
${Meter_ID}=        set global variable

*** Keywords ***

Meter Creation
    ${Meter_Id}     Meter Create
    Wait Until Keyword Succeeds     2 min       5 sec       Verify in DB        ${Meter_ID}

Register Creation
    Register Create