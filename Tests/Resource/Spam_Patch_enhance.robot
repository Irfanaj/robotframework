*** Settings ***
Library    Process
Library    OperatingSystem
Library    String
Library    CustomSapGuiLibrary.py
Library    SeleniumLibrary


*** Variables ***
${EXE_PAD}    C:\\Program Files (x86)\\SAP\\FrontEnd\\SAPgui\\saplogon.exe
${TITLE_PAD}  SAP Logon 760
${Connection_Name}    RBT
${SAP_CLIENT}   000
${SAP_USER}   DDIC
${SAP_PASSWORD}   Sym@rocks2023    
<<<<<<< HEAD
# ${search_comp}      ["ST-PI",    "BNWVS",    "ST-A/PI"]
# ${search_patch}     ["SAPK-74003INSTPI",    "SAPK-70001INBNWVS",    "SAPKITABC5"]
=======
#${search_comp}      ["ST-PI",    "BNWVS",    "ST-A/PI"]
#${search_patch}     ["SAPK-74003INSTPI",    "SAPK-70001INBNWVS",    "SAPKITABC5"]
>>>>>>> 0f61b94498f5b8a806651f85775bc9638d7abe71
${comp_id}  wnd[1]/usr/tabsQUEUE_CALC/tabpQUEUE_CALC_FC1/ssubQUEUE_CALC_SCA:SAPLOCS_ALV_UI:0306/cntlCONTROL_ALL_COMP/shellcont/shell
  


# System Variables
${continue_id}    wnd[1]/tbar[0]/btn[0]
${text_id}    wnd[1]/usr/txtMESSTXT1
${status_line}    wnd[0]/usr/txtPAT100-PATCH_STEP
${no_Queue_id}    wnd[0]/usr/txtPAT100-STAT_LINE2
${finish_str}   Confirm queue
${status_line}    wnd[0]/usr/sub:SAPLSAINT_UI:0100/txtWA_COMMENT_TEXT-LINE[0,0]
${refresh_id}   wnd[0]/tbar[1]/btn[30]
${button_id}    wnd[0]/mbar/menu[0]/menu[5]

*** Keywords *** 
RBT Logon
    Start Process    ${EXE_PAD}
    Sleep   5s
    Connect To Session
    Sleep    5
    Open Connection     ${Connection_Name}
    Sleep   5
    CustomSapGuiLibrary.Input Text    wnd[0]/usr/txtRSYST-MANDT    ${SAP_CLIENT}
    Sleep    1
    CustomSapGuiLibrary.Input Text    wnd[0]/usr/txtRSYST-BNAME    ${SAP_USER}    
    Sleep    1
    CustomSapGuiLibrary.Input Password    wnd[0]/usr/pwdRSYST-BCODE    ${SAP_PASSWORD}    
    Sleep   2
    Send Vkey    0
    Sleep    5
    Take Screenshot    A01_loginpage.jpg

Spam Transaction
    Run Transaction     spam  
    Sleep    5
    Take Screenshot    B01_spam.jpg

Certificate Verification
    Get Maintenance Certificate Text    wnd[0]/sbar/pane[0]
    Sleep    2
    Take Screenshot    C01_Certificate.jpg

Loading package
    
    CustomSapGuiLibrary.Click Element    wnd[0]/mbar/menu[0]/menu[0]/menu[1]
    Sleep    2
    Take Screenshot    D01_Load_1.jpg
    CustomSapGuiLibrary.Click Element    wnd[1]/usr/btnSPOP-OPTION1
    Sleep    2
    Take Screenshot    D02_Load_2.jpg
    CustomSapGuiLibrary.Click Element    wnd[0]/tbar[0]/btn[3]
    Sleep    2
    Take Screenshot    D03_Load_3.jpg

Display/Define
    CustomSapGuiLibrary.Click Element    wnd[0]/usr/btnPAT100-QUEUE
    Sleep    2
    Take Screenshot    E01_Display.jpg

Spam software selection
    CustomSapGuiLibrary.Click Element    wnd[1]/tbar[0]/btn[7]
    Sleep    2
    Take Screenshot    F01_patch_1.jpg
<<<<<<< HEAD
=======
    #CustomSapGuiLibrary.Spam Multiple Patch Version Select  ${comp_id}  ${search_comp}  ${search_patch}
>>>>>>> 0f61b94498f5b8a806651f85775bc9638d7abe71
    CustomSapGuiLibrary.Spam Multiple Patch Version Select  ${comp_id}  ${symvar('search_comp')}  ${symvar('search_patch')}
    Sleep    4
    Take Screenshot    F02_patch_2.jpg
    CustomSapGuiLibrary.Click Element    wnd[1]/tbar[0]/btn[0]
    Sleep    2
    Take Screenshot    F03_patch_3.jpg
    CustomSapGuiLibrary.Click Element    wnd[1]/tbar[0]/btn[0]
    Sleep    2
    Take Screenshot    F04_patch_4.jpg

Important SAP note handling
    CustomSapGuiLibrary.Is Imp Notes Existing   wnd[1]  wnd[1]/tbar[0]/btn[0]
    Take Screenshot    G01_SAP_note.jpg
    CustomSapGuiLibrary.Click Element    wnd[2]/tbar[0]/btn[0]
   
    CustomSapGuiLibrary.Click Element    wnd[1]/usr/btnBUTTON_2
    Take Screenshot  G02_Modification.jpg  
   
Importing queue from support package
    CustomSapGuiLibrary.Click Element    wnd[0]/mbar/menu[0]/menu[3]
    CustomSapGuiLibrary.Click Element    wnd[1]/tbar[0]/btn[0]
    Take Screenshot    H01_Imp_que_1.jpg
    #import queue-start options
    CustomSapGuiLibrary.Click Element    wnd[1]/tbar[0]/btn[27] 
    Take Screenshot    H02_Start_options.jpg

    #CLicking "Start in background immediately"
    Sleep   1
    CustomSapGuiLibrary.Select Radio Button    wnd[1]/usr/tabsSTART_OPTIONS/tabpSTART_FC1/ssubSTART_OPTIONS_SCA:SAPLOCS_UI:0701/radLAY0700-RB1_BTCHIM
    Sleep   1
    Take Screenshot    H03_Start_bkgd.jpg
    CustomSapGuiLibrary.Click Element    wnd[1]/tbar[0]/btn[0]
    Sleep   1
    Take Screenshot    H04_Start_bkgd_2.jpg    
    CustomSapGuiLibrary.Click Element    wnd[1]/tbar[0]/btn[25]
    Take Screenshot    H05_Start_bkgd_3.jpg
    Sleep    1


Confirm Queue
    
    ${cell_text_1}    CustomSapGuiLibrary.Get Finish Cell Text1    ${finish_str}    ${button_id}    ${status_line}    ${refresh_id}
    Log    ${cell_text_1}
    #CustomSapGuiLibrary.Click Element    wnd[0]/mbar/menu[0]/menu[5]
    Take Screenshot    G01_Confirmed_queue.jpg
    #Status check: No queue has been defined
    CustomSapGuiLibrary.No Queue Pending    ${no_Queue_id}
    Take Screenshot    G02_Status_Confirmed_queue1.jpg
    #Click DoNOTSEND
    CustomSapGuiLibrary.Click Element   wnd[1]/tbar[0]/btn[27]
    Take Screenshot    G03_Status_Confirmed_queue2.jpg

