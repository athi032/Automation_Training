*** Settings ***
Library    Selenium2Library
Resource    ../resources/robot_keywords/keywords.robot
Variables    ../resources/python_support/Calculator.py

Suite Setup    Log    This is Test Suite Setup    
Suite Teardown    Log    This is Test Suite Teardown    

Test Setup    My Test Setup   ${BROWSER}    ${EXE_PATH}
Test Teardown    My Test Teardown 

Default Tags    tag01
Force Tags    tag02

*** Variables *** 


*** Test Cases ***
Test Upload file
    [Tags]    upload_file_test 
    
    ${pageTitle}=    Navigate To URL    &{LINKS}[upload_file]     
    Should Contain    ${pageTitle}    File Upload    
    
    Press Key   &{LOCATORS}[file]     C:\\Users\\OneDrive\\Pictures\\blue ocean waves.jpeg      
    ${fileName}=    Get Value    &{LOCATORS}[file]    
    Should Contain    ${fileName}    blue ocean waves.jpeg    
  
Test Iframe
    [Tags]    iframe_test    
    
    ${pageTitle}=    Navigate To URL    &{LINKS}[iframe]      
    Should Contain    ${pageTitle}    Iframe    
     
    Check h1 Element    HTML Iframes    
    
    Select Frame    &{LOCATORS}[frame]      
    Check h1 Element    HTML Tutorial 
    
    Select Window    MAIN    
    Check h1 Element    HTML Iframes      

Test New Tab  
    [Tags]    new_tab_test
    
    ${pageTitle}=    Navigate To URL    &{LINKS}[google]      
    Title Should Be    ${pageTitle}   
    
    Execute Javascript    window.open('')
    Get Window Titles
    Select Window    title=undefined
    
    ${pageTitle}=   Navigate To URL      &{LINKS}[youtube]
    Should Be Equal    ${pageTitle}   YouTube
     
    Select Window    MAIN
    Title Should Be    Google    
     
Test Popout Windows   
    [Tags]    popout_windows
    
    ${pageTitle}=    Navigate To URL    &{LINKS}[new_window]        
    Should Contain    ${pageTitle}   Open a New Browser Window
    
    Execute Javascript    window.scrollTo(0, 500)
    
    Click Element    &{LOCATORS}[new_window_btn]    
    
    @{windowHandle}=    Get Window Handles
    
    Select Window    @{windowHandle}[1]
    ${page2Title}=    Get Title
    Should Contain    ${page2Title}    Open a New Window using JavaScript    
    
    Select Window    @{windowHandle}[0]
    ${pageTitle}=    Get Title
    Should Contain    ${pageTitle}    Open a New Browser Window      
    
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
    
    ${page_title}=    Navigate To URL    &{LINKS}[gmail] 
    Should Contain    ${pageTitle}   Gmail
    
    Input Text    &{LOCATORS}[identifier]    blue0703t@gmail.com
    Click Element    &{LOCATORS}[identifierNext]   
    
    Wait Until Page Contains Element    &{LOCATORS}[pass]    
    Input Text    &{LOCATORS}[pass]    blue0703t@gmail.com
    ${status}=    Run Keyword And Return Status   Click Element  &{LOCATORS}[passNext]
    
    Run Keyword If    not ${status}    Capture Page Screenshot            