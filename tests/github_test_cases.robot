*** Settings ***
Library    Selenium2Library
Library    Process
Library    ../resources/python_support/image_support.py

Resource    ../resources/robot_keywords/github_resources.robot

Suite Setup    Common Suite Setup    ${GITHUB_PROFILE}
Suite Teardown    Common Suite Teardown

Test Teardown    Common Test Teardown

Force Tags    github_test

*** Test Cases ***
Test Change Avatar Github
    [Documentation]    Test Change Avatar Github Update Correctly
    [Tags]    avatar_test

    Run Keyword And Ignore Error    Login Account    ${MAIL_TEST}    ${PASS_TEST}

    Click Element    ${EDIT_BTN}
    ${check_remove}=    Run Keyword And Return Status    Element Should Be Visible    ${REMOVE_BTN}
    Run Keyword If    ${check_remove}    Accept Confirmation Alert    ${REMOVE_BTN}
    Element Should Not Be Visible    ${REMOVE_BTN}

    Change Avatar  ${BLUE_IMG}

    Download Image    ${AVA}    ${IMG_AFTER_CHANGED}

    ${check}=    Compare Image    ${BLUE_IMG}    ${IMG_AFTER_CHANGED}
    Run Keyword If   ${check}    Log    Updated correctly    ELSE    Log    Updated uncorrectly

Show Error Message
    [Documentation]    Show error message if avatar is updated uncorrectly
    [Tags]    show_message

    Run Keyword And Ignore Error    Login Account    ${MAIL_TEST}    ${PASS_TEST}

    Change Avatar  ${BLUE_IMG}

    ${check_fail}=    Run Keyword And Return Status    Element Should Be Visible    ${BAD_FILE_MESS}
    Run Keyword If    ${check_fail}    Get Fail Message