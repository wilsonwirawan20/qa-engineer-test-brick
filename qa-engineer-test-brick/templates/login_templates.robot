*** Settings ***
Resource    ../../../resources/login_keyword.robot

*** Keywords ***
Login API
    Setup login endpoint

User is not yet log in
    ${jwt}=    Get Variable Value    ${JWT}    ${EMPTY}
    Should Be True    '${jwt}' == '${EMPTY}'

User login with username and password
    [Arguments]    ${user}    ${password}    ${platform}
    ${LOGIN_RESPONSE}=    Do login    ${user}    ${password}    ${platform}
    Set Test Variable    ${LOGIN_RESPONSE}

User login
    User logged in

User should be able to login successfully
    Run Keyword And Continue On Failure    Status Should Be    200    ${LOGIN_RESPONSE}
    ${status}=    Run Keyword And Return Status    Status Should Be    200
    IF    '${status}' == 'False'
        Sum up Error    Login | status code is ${LOGIN_RESPONSE.status_code}
    END
    Log    Status code is 200

User should not be able to login
    Run Keyword And Continue On Failure    Status Should Be    400    ${LOGIN_RESPONSE}
    ${status}=    Run Keyword And Return Status    Status Should Be    400
    IF    '${status}' == 'False'
        Sum up Error    Login | status code is ${LOGIN_RESPONSE.status_code}
    END
    Log    Status code is 400
