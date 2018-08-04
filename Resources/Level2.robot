*** Settings ***
Library    String        #Required for Generate Random String
Library    SudsLibrary    #Required for SOAP related operations
Library     xml.etree.cElementTree
Library     DateTime
Library    ../Resources/xml_edit.py
Library  DatabaseLibrary

*** Variables ***
${Today}=       set global variable     Get Current Date        result_format=%Y-%m-%d


*** Keywords ***

Meter Create
    Log     This test case shall create a meter using ISAIM
    ${GetMaxTask}  Query   SELECT MAX(TASKID) FROM TASK
    ${Meter_ID}  ${MeterDataReceived}=  Meter_Create_Request  ${GetMaxTask}
    ${Message}    Create Raw Soap Message    ${MeterDataReceived}
    Set Location	http://ral-arkansas.itronhdc.com:8000/V1/IEESAPAdapter
    Call Soap Method    UtilitiesDeviceERPSmartMeterCreateRequest_In    ${Message}
    set global variable     ${Meter_ID}
    [return]  ${Meter_ID}

Register Create
    Log     This test case shall create the registers using ISAIM
    Log     ${Meter_ID}
#    ${Message}    Create Raw Soap Message    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:glob="http://sap.com/xi/SAPGlobal20/Global"><soapenv:Header/><soapenv:Body><glob:UtilitiesDeviceERPSmartMeterRegisterCreateRequest><MessageHeader><UUID>${operationId}</UUID><CreationDateTime>2017-12-12T15:39:22Z</CreationDateTime><SenderBusinessSystemID>SapDefaultSystem</SenderBusinessSystemID></MessageHeader><UtilitiesDevice><ID>Robot${DeviceID}</ID><RegisterGroup><StartDate>2016-11-24</StartDate><EndDate>9999-12-31</EndDate><RegisterGroupID>Final_ISM_33</RegisterGroupID></RegisterGroup><Register><StartDate>2016-11-24</StartDate><EndDate>9999-12-31</EndDate><UtilitiesMeasurementTaskID>UMTID1_${DeviceID}</UtilitiesMeasurementTaskID><UtilitiesObjectIdentificationSystemCodeText>KWH</UtilitiesObjectIdentificationSystemCodeText><UtiltiesMeasurementTaskCategoryCode>5</UtiltiesMeasurementTaskCategoryCode><TimeZoneCode>EST</TimeZoneCode><Specifications><MeasureUnitCode>KWH</MeasureUnitCode><DecimalValuePrecision><TotalDigitNumberValue>10</TotalDigitNumberValue><FractionDigitNumberValue>10</FractionDigitNumberValue></DecimalValuePrecision><MeterReadingResultAdjustmentFactorValue>9856.2650900000</MeterReadingResultAdjustmentFactorValue></Specifications></Register><Register><StartDate>2016-11-24</StartDate><EndDate>9999-12-31</EndDate><UtilitiesMeasurementTaskID>UMTID2_${DeviceID}</UtilitiesMeasurementTaskID><UtilitiesObjectIdentificationSystemCodeText>KWH</UtilitiesObjectIdentificationSystemCodeText><UtiltiesMeasurementTaskCategoryCode>4</UtiltiesMeasurementTaskCategoryCode><UtilitiesMeasurementRecurrenceCode>15</UtilitiesMeasurementRecurrenceCode><TimeZoneCode>EST</TimeZoneCode><Specifications><UtilitiesTimeOfUseCode>0003</UtilitiesTimeOfUseCode><MeasureUnitCode>KWH</MeasureUnitCode><DecimalValuePrecision><TotalDigitNumberValue>10</TotalDigitNumberValue><FractionDigitNumberValue>10</FractionDigitNumberValue></DecimalValuePrecision><MeterReadingResultAdjustmentFactorValue>1.0000000000</MeterReadingResultAdjustmentFactorValue></Specifications></Register><SmartMeter><UtilitiesAdvancedMeteringSystemID>I210</UtilitiesAdvancedMeteringSystemID></SmartMeter></UtilitiesDevice></glob:UtilitiesDeviceERPSmartMeterRegisterCreateRequest></soapenv:Body></soapenv:Envelope>
#    Call Soap Method    UtilitiesDeviceERPSmartMeterRegisterCreateRequest_Out    ${Message}
#
