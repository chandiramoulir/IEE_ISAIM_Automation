### This is to validate multiple xml files in a directory.

import sys, time
import os
import re
import random
import lxml.etree as et
from datetime import datetime

from robot.api import deco
from robot.api import logger
from robot.api.deco import keyword


global UUID, UUID_dict
global s1
s1="{http://sap.com/xi/SAPGlobal20/Global}"
UUID_dict={}
print(datetime.now().time().microsecond)

@keyword('Message_Header')
def MessageHeader(request_type):
    print("Inside Message header")
    UUID = random.randint(100000000000,999999999999)
    print(UUID)
    for msg in tree.iter():
        if(msg.tag == "CreationDateTime"):
            msg.text = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")
    UUID_dict[UUID]=request_type
    print(UUID_dict)
    return UUID

@keyword('Meter_Create_Request')
def MeterCreate_XML_Request(TaskID):
    global tree, DeviceID
    DeviceID = (int(TaskID[0][0]) + 1)
    Meter_ID = 'Robo'+ str(DeviceID)
    tree = et.parse('C:\\Mouli\\Personal\\Python\\Robot_Soap_San\\Input\\UtilsDvceERPSmrtMtrCrteReqMsg_20180622-233004496_6d3abff4-8995-4dc9-b0df-9af54bb2d6d1_Original.xml')
    root = tree.getroot()
    ID = str(datetime.now().time().microsecond)
    print("*INFO* Found the source file and the request type is ", root.tag)
    #print("root tag: ",root.tag)
    UUID_get = long(MessageHeader("UtilsDvceERPSmrtMtrCrteReqMsg"))
    for elem in tree.iter():
        print(elem.tag, elem.text)
        if (elem.tag == "UUID"):
            elem.text = str(UUID_get)
        if(elem.tag == "ID"):
            elem.text= Meter_ID
        if(elem.tag == "SerialID"):
            elem.text = 'S'+ str(DeviceID)
        if (elem.tag == "MaterialID"):
            elem.text = 'M' + str(DeviceID)
        if (elem.tag == "ProductUniqueItemID"):
            elem.text = 'P' + str(DeviceID)

    meterCreateData_xml = tree.write('C:\\Mouli\\Personal\\Python\\Robot_Soap_San\\Input\\UtilsDvceERPSmrtMtrCrteReqMsg_20180622-233004496_6d3abff4-8995-4dc9-b0df-9af54bb2d6d1_Original.xml')
    fobj = open('C:\\Mouli\\Personal\\Python\\Robot_Soap_San\\Input\\UtilsDvceERPSmrtMtrCrteReqMsg_20180622-233004496_6d3abff4-8995-4dc9-b0df-9af54bb2d6d1_Original.xml','r')
    meterCreateData = fobj.read()
    print("*INFO*", meterCreateData)
    fobj.close()
    return Meter_ID, meterCreateData


def MeterCreate_XML_Response():

    ##  parse through the folder for each file
    ##  Take UUID and request type as two variables
    ##  For each UUID, verify Notes and conclude the result of each request
    ##
#####(a) one way of getting the logs.
    print("*INFO*Validation of response")
    tree = et.parse('C:\\Mouli\\Personal\\Python\\Robot_Xml_validation\\inputs\\UtilsDvceERPSmrtMtrCrteConfMsg_20180622-233040299_72d92915-852b-435d-989b-4b084227a35d.xml')
    root = tree.getroot()
    print ("root of the file: ",root.tag)
    for level1 in root.iterfind('Log'):
        #print("Found", *level1)
        for elem in level1.iterfind('Item'):
            #print("Found", *elem)
            for details in elem.iter():
                print(details.tag, details.text)

####(b) another way = Regex way
    Note_pattern = re.compile(r"<Note>(.*)</Note>")
    UUID_pattern = re.compile(r"<ReferenceUUID>[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*</ReferenceUUID>", re.DOTALL)
    response_pattern = re.compile(r"<s1:(.*) xmlns", re.DOTALL)
    directory = os.listdir('C:\\Mouli\\Personal\\Python\\Robot_Xml_validation\\inputs\\Log_ConfirmationToSap')
    os.chdir("C:\\Mouli\\Personal\\Python\\Robot_Xml_validation\\inputs\\Log_ConfirmationToSap")
    print(directory)
    #for xfile in directory:
    for xfile in directory:
        open_file = open(xfile,"r")
        write_file = open("C:\\Mouli\\Personal\\Python\\Robot_Xml_validation\\Results\\Results.txt",'a+')
        fdata = open_file.read()
        #print(xfile)
        #print(UUID_pattern.findall(fdata)) #--working
        #print(response_pattern.findall(fdata)) #--working
        print(Note_pattern.findall(fdata))
        write_file.write("File name:" + str(xfile)+ "\n")
        write_file.write("Response type:" + str(response_pattern.findall(fdata))+ "\n")
        write_file.write("Reference ID:" + str(UUID_pattern.findall(fdata))+ "\n")
        write_file.write("Log:" + str(Note_pattern.findall(fdata))+ "\n\n")
        #write_file.write("\n")
        open_file.close()
        write_file.close()
    #print(data)

# MeterCreate_XML_Request()
# MeterCreate_XML_Response()