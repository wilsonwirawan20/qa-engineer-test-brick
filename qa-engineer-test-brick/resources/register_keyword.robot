*** Settings ***
Resource          ../base/base_keyword.robot

*** Variables ***
${isLoggedIn}     ${False}
${PLATFORM_WEB}    web
${INVALID_DATA}    qwerty
${X-Ht-Ver-Id}    

*** Keywords ***
Register Account
    [Arguments]    ${username}    ${password}
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    Click Button    id=register_button
    Wait Until Element Is Visible    id=success_message