*** Settings ***
Library           Selenium2Library

*** Variables ***
${SERVER}               192.168.99.100:30877
${DELAY}                0
${VALID USER}           admin
${VALID PASSWORD}       password
${LOGIN URL}            http://${SERVER}/wp-login.php
${WELCOME URL}          http://${SERVER}/wp-admin/

*** Keywords ***
Open Browser To Login Page
    Open Browser            about:blank     browser=headlesschrome
    Go To Login Page
    Set Selenium Speed      ${DELAY}

Go To Login Page
    Go To                   ${LOGIN URL}

Input Username
    [Arguments]             ${username}
    Input Text              user_login      ${username}

Input Password
    [Arguments]             ${password}
    Input Text              user_pass       ${password}

Submit Credentials
    Click Element           wp-submit

Welcome Page Should Be Open
    Page Should Contain     Dashboard
