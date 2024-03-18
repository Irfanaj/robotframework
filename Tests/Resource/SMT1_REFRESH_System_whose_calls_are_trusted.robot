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
    #Input Password   wnd[0]/usr/pwdRSYST-BCODE    ${symvar('User_Password')}   
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

SMT1_T_CODE_System_whose_calls_are_trusted
    Run Transaction    /nSMT1
    FOR    ${i}    IN RANGE    2    999       
        ${select_only}    Select Only    wnd[0]/usr/tabsTRUST_STRIP/tabpTRUST_STRIP_FC1/ssubTRUST_STRIP_SCA:RS_RFC_TT_UI:0110/cntlSERVER_CONTAINER/shellcont/shell/shellcont[1]/shell[1]    ${i}
        Sleep    1
        Click Toolbar Button    wnd[0]/usr/tabsTRUST_STRIP/tabpTRUST_STRIP_FC1/ssubTRUST_STRIP_SCA:RS_RFC_TT_UI:0110/cntlSERVER_CONTAINER/shellcont/shell/shellcont[1]/shell[0]    DISPLAY
        Sleep    2
        Click Element    wnd[0]/usr/tabsTRUSTINGT_STRIP/tabpTRUSTINGT_STRIP_FC1
        Take Screenshot    ${i}_System_whose_calls_are_trusted_CONFIGURATION.jpg
        Sleep    1
        Click Element    wnd[0]/usr/tabsTRUSTINGT_STRIP/tabpTRUSTINGT_STRIP_FC2
        Take Screenshot    ${i}_System_whose_calls_are_trusted_SYSTEM_SETTING.jpg
        Sleep    1
        Click Element    wnd[0]/usr/tabsTRUSTINGT_STRIP/tabpTRUSTINGT_STRIP_FC3
        Take Screenshot    ${i}_System_whose_calls_are_trusted_ADMINISTRATION.jpg
        Sleep    1
        Click Element    wnd[0]/tbar[0]/btn[3]
        Sleep    1
        Unselect    wnd[0]/usr/tabsTRUST_STRIP/tabpTRUST_STRIP_FC1/ssubTRUST_STRIP_SCA:RS_RFC_TT_UI:0110/cntlSERVER_CONTAINER/shellcont/shell/shellcont[1]/shell[1]    ${i}
        Sleep    1
        ${Exit_point}    Run Keyword And Return Status    Run Keyword If     ${select_only} != 'NONE'    Log    Selected Rows: ${select_only}
        Exit For Loop If     ${Exit_point}=='NONE'
            
    END
