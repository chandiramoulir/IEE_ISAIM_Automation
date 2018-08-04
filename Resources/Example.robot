*** Settings ***
Library           SudsLibrary
Library           XML

*** Test Cases ***
Successful Celsius to Fahrenheit Conversion
    Given I have a value of 1 Celsius
    When I send it for Fahrenheit conversion
    Then I should get 33.8 Fahrenheit

Examples
    [Template]    Given ${input_celsius} Should be ${expected_fahrenheit}
    1    33.8
    2    35.6
    100    100

*** Keywords ***
I have a value of ${input_celsius} Celsius
    Create Soap Client    http://www.w3schools.com/webservices/tempconvert.asmx?WSDL
    ${CelsiusToFahrenheit}    Create Wsdl Object    CelsiusToFahrenheit
    Log    ${CelsiusToFahrenheit}
    ${CelsiusToFahrenheit.Celsius}    Set Variable    ${input_celsius}
    Set Test Variable    ${CelsiusToFahrenheit}

I send it for Fahrenheit conversion
    Call Soap Method    CelsiusToFahrenheit    ${CelsiusToFahrenheit}

I should get ${expected_fahrenheit} Fahrenheit
    ${soap_response}    Get Last Received
    Log    ${soap_response}
    Element Text Should Be    ${soap_response}    ${expected_fahrenheit}    .//CelsiusToFahrenheitResponse[1]/CelsiusToFahrenheitResult[1]

Given ${input_celsius} Should be ${expected_fahrenheit}
    I have a value of ${input_celsius} Celsius
    I send it for Fahrenheit conversion
    I should get ${expected_fahrenheit} Fahrenheit