*** Settings ***
Resource    ../../../resources/register_keyword.robot

*** Keywords ***
Register API
    Setup register endpoint

User is not yet register
    ${jwt}=    Get Variable Value    ${JWT}    ${EMPTY}
    Should Be True    '${jwt}' == '${EMPTY}'

User register with username and password
    [Arguments]    ${user}    ${password}    ${platform}
    ${LOGIN_RESPONSE}=    Do register    ${user}    ${password}    ${platform}
    Set Test Variable    ${REGISTER_RESPONSE}

User register
    User registered

User should be able to register successfully
    Run Keyword And Continue On Failure    Status Should Be    200    ${REGISTER_RESPONSE}
    ${status}=    Run Keyword And Return Status    Status Should Be    200
    IF    '${status}' == 'False'
        Sum up Error    Login | status code is ${REGISTER_RESPONSE.status_code}
    END
    Log    Status code is 200

User should not be able to Register
    Run Keyword And Continue On Failure    Status Should Be    400    ${REGISTER_RESPONSE}
    ${status}=    Run Keyword And Return Status    Status Should Be    400
    IF    '${status}' == 'False'
        Sum up Error    Login | status code is ${REGISTER_RESPONSE.status_code}
    END
    Log    Status code is 400
