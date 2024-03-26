*** Settings ***
Resource          ../base/base_keyword.robot

*** Variables ***
${isLoggedIn}     ${False}
${PLATFORM_WEB}    web
${INVALID_DATA}    qwerty
${X-Ht-Ver-Id}    

*** Keywords ***
Setup login endpoint
    Set Test Variable    ${login_endpoint}    ${CONFIG.Environment.AJAIB_URL}/api/v5/login/


Do login 
    [Arguments]    ${username}    ${password}    ${platform}
    ${headers}=    Create Dictionary    X-Ht-Ver-Id=${X-Ht-Ver-Id}
    ${body}=    Create Dictionary    email=${username}    password=${password}    platform=${platform}
    ${response}=    POST    url=${login_endpoint}    json=${body}    headers=${headers}    expected_status=Anything
    [Return]    ${response}

    
Get JWT 
    Setup login endpoint
    ${response}=    Do login    ${CONFIG.Environment.VALID_USER}    ${CONFIG.Environment.VALID_PASSWORD}    ${PLATFORM_WEB}
    ${jwt}=    Set Variable    ${EMPTY}
    IF    ${response.status_code} == 200
        ${jwt}=    Convert To String    ${response.json()}[access_token]
    END
    [Return]    ${jwt}


User logged in
    ${login_response}=    Get JWT 
    ${isLoggedIn}=    Evaluate    '${login_response}[access_token]' != '${EMPTY}'
    Set Suite Variable    ${isLoggedIn}
    Set Suite Variable    ${JWT}    ${login_response}[access_token]
    Set Suite Variable    ${pin_token}    ${login_response}[pin_token]
