*** Settings ***
Library    Selenium2Library
Library    requests
Library     Dialogs
Resource    ../resources/robot_keywords/common_keywords.robot
Variables    ../resources/python_support/calculator.py

Suite Setup    Common Suite Setup
Suite Teardown    Common Suite Teardown  

Test Setup    Common Test Setup   ${BROWSER}    ${EXE_PATH}
Test Teardown    Common Test Teardown 

Default Tags    d_tag
Force Tags    main_tag

*** Test Cases ***
Test Upload file
    [Tags]    upload_file_test 
    
    ${pageTitle}=    Navigate To URL    ${W3_UPLOAD_FILE}     
    Should Contain    ${pageTitle}    File Upload    
    
    Press Key   ${FILE_LC}    ${BLUE_IMG}      
    ${fileName}=    Get Value    ${FILE_LC}    
    Should Contain    ${fileName}    blue ocean waves.jpeg    
  
Test Iframe
    [Tags]    iframe_test    
    
    ${pageTitle}=    Navigate To URL    ${W3_IFRAME}      
    Should Contain    ${pageTitle}    Iframe    
     
    Check h1 Element    HTML Iframes    
    
    Select Frame    ${FRAME_LC}      
    Check h1 Element    HTML Tutorial 
    
    Wait Until Element Is Enabled    ${JS_NAV}    
    Click Element    ${JS_NAV}  
    Check h1 Element    JavaScript Tutorial 
    
    Select Window    MAIN    
    Check h1 Element    HTML Iframes      

Test New Tab  
    [Tags]    new_tab_test
    
    ${pageTitle}=    Navigate To URL    ${GOOGLE}      
    Title Should Be    ${pageTitle}   
    
    Execute Javascript    window.open('')
    Get Window Titles
    Select Window    title=undefined
    
    ${pageTitle}=   Navigate To URL      ${YOUTUBE}
    Should Be Equal    ${pageTitle}   YouTube
     
    Select Window    MAIN
    Title Should Be    Google    
     
Test Popout Windows   
    [Tags]    popout_windows
    
    ${pageTitle}=    Navigate To URL    ${LINK_NEW_WINDOWS}        
    Should Contain    ${pageTitle}   Open a New Browser Window
    
    Execute Javascript    window.scrollTo(0, 500)
    
    Click Element    ${NEW_WINDOW_BTN}    
    
    @{windowHandle}=    Get Window Handles
    
    Select Window    @{windowHandle}[1]
    ${page2Title}=    Get Title
    Should Contain    ${page2Title}    Open a New Window using JavaScript    
    
    Select Window    @{windowHandle}[0]
    ${pageTitle}=    Get Title
    Should Contain    ${pageTitle}    Open a New Browser Window   
    
Test API
    [Tags]    api_test
    
    ${pageTitle}=    Navigate To URL    ${ANY_API}        
    Should Contain    ${pageTitle}   AnyAPI  
    
    @{leftNavList}=    Get WebElements    ${LEFT_NAV}    
    :FOR    ${nav}    IN    @{leftNavList}
    \    Wait Until Element Is Enabled    ${nav}    
    \    Click Element    ${nav}    
    \    ${location}=    Get Location
    \    ${re}=    Get    ${location}    timeout:5     
    \    Should Be Equal As Integers    ${re.status_code}       200
    
Basic Calculator
    [Tags]    call_method_test
    
    ${addittion}=    Call Method    ${cal}   add   20   30
    Should Be Equal As Numbers    ${addittion}    50    
    
    ${is_contain_apple}=    Call Method   ${cal}    kwargs_demo_1   orange  mango  apple  kiwi
    Should Be True    ${is_contain_apple}==True     
    
    ${is_contain_mango}=    Call Method   ${cal}    kwargs_demo_2    name=abc   salary=1000   fruit=mango
    Should Be True    ${is_contain_mango}==True   
    
Capture Sreen Demo
    [Tags]    capture_screen_test
    
    ${page_title}=    Navigate To URL    ${GMAIL} 
    Should Contain    ${pageTitle}   Gmail
    
    Input Text    ${IDENTIFIER}    blue0703t@gmail.com
    Click Element    ${IDENTIFIER_NEXT}   
    
    Wait Until Page Contains Element    ${PASS}    
    Input Text    ${PASS}    blue0703t@gmail.com
    ${status}=    Run Keyword And Return Status   Click Element  ${PASS_NEXT}
    
    Run Keyword If    not ${status}    Capture Page Screenshot