*** Settings ***

Suite Setup  Suite_setting_up
##verify WSDL connection
##Verify DB connection
Suite Teardown  Suite_TearDown
Test Setup  Test_setting_up
Test Teardown  Test_Teardown

*** Variables ***


*** Test Cases ***

Test__001
    Log To Console  This is test 001

Test__002
    Log To Console  This is test 002

*** Keywords ***

Suite_setting_up
    Log To Console  Initializing the suite for the 1st time...

Suite_TearDown
    Log To Console  Tearing down the suite...

Test_setting_up
    Log To Console  Setting the tests up...

Test_Teardown
    Log To Console  Closing the test..