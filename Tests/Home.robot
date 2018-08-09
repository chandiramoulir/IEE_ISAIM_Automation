*** Settings ***
Library    String        #Required for Generate Random String
Library    SudsLibrary    #Required for SOAP related operations
Library     xml.etree.cElementTree
Library     DateTime
Resource    ../Resources/Level2.robot
Resource    ../Resources/db_connect.robot
Resource    ../Resources/Level1.robot

Suite Setup  ISAIM_startup
Suite Teardown  ISAIM_dismantle

*** Test Cases ***

Create Configuration Services
        Level1.Call Meter Create
        Level1.Call Register Create
        Level1.Call Meter Location

Change Configuration Services
        No Operation
Interval Billing Services
        No Operation
Two-Way Control Services
        No Operation
Device Event Services
        No Operation
Reading Data Collection Services
        No Operation

*** Keywords ***
ISAIM_startup
    Set Log Level       DEBUG
    Connect To Database Using Custom Params    cx_Oracle    '${oracleUsername}/${oraclePassword}@${oracleDbHost}:${oracleDbPort}/${oracleDatabaseName}'
    Create Soap Client    http://ral-arkansas.itronhdc.com:8000/V1/IEESAPAdapter?wsdl
    #Check if ISAIM installed (by creating SOAP client, you can come to know)
    #Drop the programs (needed for RegisterCreate)
    #Make sure you are able to access the SAP Logs

ISAIM_dismantle
    Disconnect From Database

