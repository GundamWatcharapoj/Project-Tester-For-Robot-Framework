*** Settings ***
Resource        ../resources/keyword.robot
Suite Setup     Set Selenium Speed    0.2s

*** Test Cases ***
TC_AUTH_001: Login With Valid Credentials
    [Documentation]    
    [Tags]    auth    smoke
    Open Login Page
    Login page    ${USERNAME}    ${PASSWORD}
    Page Should Contain    ${NAME_WEB_MESSAGE}
    [Teardown]    Close Browser

TC_AUTH_002: Login With Invalid Username
    [Documentation]    
    [Tags]    auth    negative
    Open Login Page
    Login page    ${INVALID_USERNAME}    ${PASSWORD}
    Wait Until Page Contains    ${INVALID_USERNAME_MESSAGE}
    [Teardown]    Close Browser

TC_AUTH_003: Login With Invalid Password
    [Documentation]    
    [Tags]    auth    negative
    Open Login Page
    Login page    ${USERNAME}    ${INVALID_PASSWORD}
    Wait Until Page Contains    ${INVALID_PASSWORD_MESSAGE}
    [Teardown]    Close Browser

TC_AUTH_004: Login With Empty Credentials
    [Documentation]    null password and username
    [Tags]            auth    negative
    Open Login Page 
    Login page    ${EMPTY}    ${EMPTY}
    [Teardown]    Close Browser

TC_AUTH_005: Press logout and back to login page
    [Documentation]    Verify user can logout and return to login page
    [Tags]    auth    smoke
    Open Login Page
    Login page    ${USERNAME}    ${PASSWORD}
    Wait Until Element Is Visible    ${LOGOUT_BUTTON}    timeout=10s
    Click Element    ${LOGOUT_BUTTON}
    Wait Until Location Is    ${LOGIN_URL}    timeout=5s
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    timeout=5s
    [Teardown]    Close Browser

TC_AUTH_006: Direct Access Storage Page Without Login
    [Documentation]    Verify unauthenticated user cannot access storage page
    [Tags]    auth    security
    Open Browser    ${MANAGE__STORAGE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Location Is    ${LOGIN_URL}    timeout=5s
    [Teardown]    Close Browser

TC_PROD_001: Fetch And Display Product List On Storage Page
    [Documentation]    ตรวจสอบระบบดึงรายการสินค้ามาแสดงในตารางบนหน้าแรก (คลังสินค้า) ได้ถูกต้องครบถ้วน
    [Tags]            product    smoke
    Open Login Page
    Login page                      ${USERNAME}    ${PASSWORD}
    Wait Until Location Is          ${MANAGE_STORAGE_URL}        timeout=5s
    Wait Until Element Is Visible    ${TABLE_ROW_XPATH}          timeout=5s
    [Teardown]    Close Browser

TC_PROD_002: Add Product With Complete Information
    [Documentation]    
    [Tags]    product    create

    Open Login Page
    Login page    ${USERNAME}    ${PASSWORD}

    Go To    ${MANAGE__STORAGE_URL}
    Wait Until Element Is Visible    ${PRODUCT_CODE_INPUT}    timeout=5s

    Add Product    P0010    ปูนฉาบ    ปูนซีเมนต์    100    130    50    ถุง

    [Teardown]    Close Browser