*** Settings ***
Resource          ../../../config/config.robot

*** Variables ***
${sec-fetch-site}    same-site
${sec-fetch-mode}    cors
${sec-fetch-dest}    empty
${X-Ht-Ver-Id}    769b53713ed596a1a8209a6ab427a907b729d2da4334acb39b42ec18f970622857cc459179cc76646d17cec09edda75c02026d88e1314d12cbcab957e6d214b3


*** Keywords ***
Get Header with auth
    [Arguments]    ${token}=${EMPTY}
    IF    '${token}' == '${EMPTY}'
        ${token}=    Set Variable    jwt ${JWT}
    END
    ${headers}=    Create Dictionary    Authorization=${token}    Referer=${CONFIG.Environment.REFERRER}
    ...    origin=${CONFIG.Environment.REFERRER}    sec-fetch-site=${sec-fetch-site}
    ...    sec-fetch-mode=${sec-fetch-mode}    sec-fetch-dest=${sec-fetch-dest}
    ...    X-Ht-Ver-Id=${X-Ht-Ver-Id}
    [Return]    ${headers}

Get Header
    ${headers}=    Create Dictionary    Referer=${CONFIG.Environment.REFERRER}
    ...    origin=${CONFIG.Environment.REFERRER}    sec-fetch-site=${sec-fetch-site}
    ...    sec-fetch-mode=${sec-fetch-mode}    sec-fetch-dest=${sec-fetch-dest}
    ...    X-Ht-Ver-Id=${X-Ht-Ver-Id}
    [Return]    ${headers}

Check response body is not EMPTY
    [Arguments]    ${response}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${response.content}

Load Json Data Into Dictionary
    [Arguments]    ${i_data}
    ${l_file}    Get File    ${i_data}
    ${l_data}    Evaluate    json.loads('''${l_file}''')    modules=json
    [Return]    ${l_data}

Get Session
    ${session}=    Get Variable Value    ${JWT}    ${EMPTY}
    ${isLoggedIn}=    Evaluate    '${session}' != '${EMPTY}'
    Set Suite Variable    ${isLoggedIn}

Get Code
    Set Global Variable    ${CODE}
    Log To Console    ${CODE}
    Set Global Variable    ${YEAR}
    Log To Console    ${YEAR}
