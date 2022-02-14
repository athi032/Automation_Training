***Settings***
 
***Variables***
${GITHUB_PROFILE}=    https://github.com/settings/profile
${USERNAME}=    id:login_field
${PASSWORD}=    id:password
${SIGN_IN_BTN}=    xpath://input[contains(@value, 'Sign in')]
${EDIT_BTN}=    xpath://summary/div[contains(., 'Edit')] 
${UPLOAD_BTN}=    id:avatar_upload 
${REMOVE_BTN}=    xpath://button[contains(., 'Remove photo')] 
${SET_NEW}=    xpath://button[contains(., 'Set new profile picture')] 
${BAD_FILE_MESS}=    css:div.upload-state.color-fg-danger.bad-file 
${AVA}=    css:img.avatar.rounded-2.avatar-user
${VCODE}=    js-verification-code-input-auto-submit
${VERIFY_BTN}=    xpath://button[contains(., 'Verify')] 
${AVA_SMALL}=    css:img.avatar.avatar-small.circle

${BLUE_IMG}=    ${CURDIR}\\images\\blueOcean.jpeg
${WRONG_IMG}=    ${CURDIR}\\images\\blueOcean.bmp
${IMG_AFTER_CHANGED}=    avaAfter.png
${IMG_BEFORE_CHANGED}=    avaBefore.png
${CHROME_PROFILE_PATH}=    --user-data-dir=C:\\Users\\Admin\\AppData\\Local\\Google\\Chrome\\User Data\\Default
${MAIL_TEST}=    blue0703t@gmail.com
${PASS_TEST}=    anhthi07032000

***Keywords***
Common Suite Setup
    Log    This is Suite Setup
    [Arguments]    ${url} 
    Open Chrome    ${url}
    Set Browser Implicit Wait    5s 
 
Common Test Teardown
    Log    This is Test Teardown
    Run Keyword If Test Failed    Capture Page Screenshot

Common Suite Teardown
    Log    This is Suite Teardown
    Close Browser

Login Account
    [Arguments]    ${user}    ${pass}
    Input Text    ${USERNAME}    ${user}
    Input Password    ${PASSWORD}    ${pass}
    Click Element    ${SIGN_IN_BTN}

    ${check_verify}=    Run Keyword And Return Status    Element Should Be Visible   ${VCODE}
    Run Keyword If    ${check_verify}    Verify Account

Verify Account
    ${vcode}=    Get Value From User    Input verify code:    default
    Input Text    ${VCODE}    ${vcode}
    Wait Until Page Contains Element    ${AVA_SMALL}

Change Avatar
    [Arguments]    ${img}
    Run Keyword And Ignore Error    Click Element    ${EDIT_BTN}
    Wait Until Element Is Enabled    ${UPLOAD_BTN}
    Choose File    ${UPLOAD_BTN}    ${img}
    Run Keyword And Ignore Error     Click Element    ${SET_NEW}

Get Fail Message
    ${fail_message}=    Get Text    ${BAD_FILE_MESS}   
    Log    ${fail_message}

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