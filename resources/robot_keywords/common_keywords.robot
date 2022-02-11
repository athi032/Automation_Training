*** Settings ***
Library    Selenium2Library

*** Variables ***
${BROWSER}=    chrome 

${W3_UPLOAD_FILE}=    https://www.w3schools.com/howto/howto_html_file_upload_button.asp
${W3_IFRAME}=    https://www.w3schools.com/html/html_iframe.asp
${GOOGLE}=    http://www.google.com/
${YOUTUBE}=    http://www.youtube.com/
${LINK_NEW_WINDOWS}=    https://www.encodedna.com/javascript/demo/open-new-window-using-javascript-method.htm
${GMAIL}=    https://mail.google.com/ 
${ANY_API}=    https://any-api.com/

${FRAME_LC}=    //*[@id="main"]/div[3]/iframe 
${FILE_LC}=    id:myFiles
${JS_NAV}=    xpath://a[contains(@title,"JavaScript Tutorial")]
${NEW_WINDOW_BTN}=    xpath://input[contains(@value,'Open a new window')]
${IDENTIFIER}=    id:identifierId
${IDENTIFIER_NEXT}=    id:identifierNext
${PASS}=    xpath://input[contains(@id="password")]
${PASS_NEXT}=    xpath://input[contains(@id="passwordNext")]
${LEFT_NAV}=    class:tag-link
${H1_ELEMENT}=    h1=css:#main > h1

${BLUE_IMG}=    C:\\P-workspace\\AutomationTraining\\resources\\images\\blueOcean.jpeg
${WRONG_IMG}=    C:\\P-workspace\\AutomationTraining\\resources\\images\\blueOcean.bmp
${IMG_AFTER_CHANGED}=    avaAfter.png
${IMG_BEFORE_CHANGED}=    avaBefore.png
${CHROME_PROFILE_PATH}=    --user-data-dir=C:\\Users\\Admin\\AppData\\Local\\Google\\Chrome\\User Data\\Default
${MAIL_TEST}=    blue0703t@gmail.com
${PASS_TEST}=    anhthi07032000

*** Keywords ***
Common Suite Setup
    Log    This is Suite Setup 
    Set Browser Implicit Wait    5s
 
Common Test Teardown
    Log    This is Test Teardown
    Run Keyword If Test Failed    Capture Page Screenshot 
    Close Browser
    
Common Test Setup
    Log    This is Test Setup 
    
    [Arguments]    ${browser}
    Create Webdriver   ${browser}
    Set Browser Implicit Wait    5s
    Maximize Browser Window      

Common Suite Teardown
    Log    This is Suite Teardown
    Close Browser

Navigate To URL
    [Arguments]    ${url}
    
    Go To    ${url}     
    Run Keyword And Return    Get Title

Check h1 Element
    [Arguments]    ${expected}
    ${h1Element}=    Get Text    ${H1_ELEMENT} 
    Should Be Equal    ${h1Element}    ${expected} 

Capture Image
    [Arguments]     ${lc_ava}    ${imageName}
    ${ava}=    Get Element Attribute    ${lc_ava}    src
    Log    ${ava} 
    Execute Javascript    window.open('')
    Get Window Titles
    Select Window    title=undefined
    Navigate To URL    ${ava}
    Capture Page Screenshot    ${imageName}

Download Image
    [Arguments]    ${lc_ava}    ${imageName}
    ${ava_url}=    Get Element Attribute     ${lc_ava}    src 
    Run Process    curl    -o    ${imageName}    ${ava_url}

Accept Confirmation Alert
    [Arguments]    ${btn} 
    Click Element    ${btn}
    Handle Alert    Accept

Open Chrome
    [Arguments]    ${url}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    ${CHROME_PROFILE_PATH}
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Maximize Browser Window
    Go To    ${url}