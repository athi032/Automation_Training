*** Settings ***
Library    Selenium2Library

*** Variables ***
${BROWSER}=   Chrome
${EXE_PATH}=   E:\\FSoft\\Selenium\\chromedriver_win32\\chromedriver.exe
&{LINKS}=    upload_file=https://www.w3schools.com/howto/howto_html_file_upload_button.asp
...   iframe=https://www.w3schools.com/html/html_iframe.asp
...   google=http://www.google.com/
...   youtube=http://www.youtube.com/
...   new_window=https://www.encodedna.com/javascript/demo/open-new-window-using-javascript-method.htm
...   gmail=https://mail.google.com/ 
...   any_api=https://any-api.com/
&{LOCATORS}=    frame=//*[@id="main"]/div[3]/iframe
...             h1=css:#main > h1
...             file=id:myFile
...             jsNav=xpath://a[contains(@title,"JavaScript Tutorial")]
...             new_window_btn=xpath://input[contains(@value,'Open a new window')]
...             identifier=id:identifierId
...             identifierNext=id:identifierNext
...             pass=xpath://input[contains(@id="password")]
...             passNext=xpath://input[contains(@id="passwordNext")]
...             leftNav=class:tag-link

*** Keywords *** 
My Test Setup
    Log    This is Test Setup 
    
    [Arguments]    ${browser}   ${exe_path}   
    Create Webdriver   ${browser}    executable_path=${exe_path}
    Set Browser Implicit Wait    5s
    Maximize Browser Window      
        
My Test Teardown
    Log    This is Test Teardown
    Run Keyword If Test Failed    Capture Page Screenshot        
    Close Browser
    
My Suite Teardown
    Log    This is Suite Teardown
    Close Browser

Navigate To URL
    [Arguments]    ${url}
    
    Go To    ${url}     
    Run Keyword And Return     Get Title
    
Check h1 Element
    [Arguments]    ${expected}
    ${h1Element}=    Get Text    &{LOCATORS}[h1] 
    Should Be Equal    ${h1Element}    ${expected} 
    
Test Count 1
    Log To Console    Found items as expected items   
    Close Browser
      
Test Count 2
    Log To Console    Found items less than expected items    
    Close Browser
    
Test Count 3
    Log To Console    Exception    
    Close Browser