*** Settings ***
Library    Process
Library    SAP_Tcode_Library.py
Library    OperatingSystem
Library    String

*** Keywords ***
System Logon
    Start Process     ${symvar('SAP_SERVER')}     
    Sleep    10s
    Connect To Session
    Open Connection    ${symvar('SAP_connection')}    
    Input Text    wnd[0]/usr/txtRSYST-MANDT    ${symvar('Client_Id')}
    Input Text    wnd[0]/usr/txtRSYST-BNAME    ${symvar('User_Name')}    
    Input Password   wnd[0]/usr/pwdRSYST-BCODE    %{SAP_PASSWORD}
    Send Vkey    0
    Take Screenshot    00a_loginpage.jpg
    Multiple logon Handling     wnd[1]  wnd[1]/usr/radMULTI_LOGON_OPT2  wnd[1]/tbar[0]/btn[0] 
    Sleep   1
    Take Screenshot    00_multi_logon_handling.jpg
 
System Logout
    Run Transaction   /nex
    Sleep    5
    Take Screenshot    logoutpage.jpg
    Sleep    10
WE21_T_CODE
    Run Transaction     /nWE21
    Sleep   1
    Take Screenshot    WE21.JPG
XML File
    Select Node     wnd[0]/shellcont/shell  X
    Sleep   1
    Take Screenshot    XML_0.1.jpg
    Click Element   wnd[0]/tbar[1]/btn[20]
    Sleep   1
    Take Screenshot    XML_0.2.jpg
    Click Element   wnd[1]/tbar[0]/btn[0]
    Sleep   1
    Take Screenshot    XML0.3.jpg

XML HTTP
    Select Node     wnd[0]/shellcont/shell  H
    Sleep   1
    Take Screenshot    HTTP_1.1.jpg
    Click Element   wnd[0]/tbar[1]/btn[20]
    Sleep   1
    Take Screenshot    HTTP_1.2.jpg
    Click Element   wnd[1]/tbar[0]/btn[0]
    Sleep   1
    Take Screenshot    HTTP_1.3.jpg