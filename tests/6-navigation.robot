*** Settings ***
Documentation     Test Cases สำหรับการนำทาง (Navigation)
Resource          ../resources/keyword.robot
Suite Setup       Login As Valid User
Suite Teardown    Close Browser Session

*** Test Cases ***
TC_NAV_001 สลับหน้าใช้งานผ่าน Sidebar
    [Documentation]    คลิกเมนูต่างๆ บน Sidebar ตรวจสอบ URL และเนื้อหาที่ถูกต้อง
    [Tags]    Navigation
    Go To Products Page
    Click Element    id=nav-withdraw
    Wait Until Location Is    ${BASE_URL}/withdraw    timeout=5s
    Wait Until Page Contains Element    id=product_id
    Click Element    id=nav-history
    Wait Until Location Is    ${BASE_URL}/history    timeout=5s
    Wait Until Page Contains Element    id=historyList
    Click Element    id=nav-products
    Wait Until Location Is    ${BASE_URL}/    timeout=5s
    Wait Until Page Contains Element    id=searchInput

TC_NAV_002 ตรวจสอบการแสดงผลหน้าเกี่ยวกับเรา
    [Documentation]    คลิกเมนู "เกี่ยวกับเรา" ตรวจสอบรายละเอียดครบถ้วน
    [Tags]    Navigation
    Go To About Page
    Page Should Contain    ประวัติและวิสัยทัศน์
    Page Should Contain    จุดเด่นและการให้บริการ
    Page Should Contain    ข้อมูลการติดต่อและสถานที่ตั้ง
    Page Should Contain    02-123-4567
    Page Should Contain    contact@construction-wh.com
    ${feature_cards}=    Get Element Count    css=.feature-card
    Should Be Equal As Numbers    ${feature_cards}    4    msg=ต้องแสดงจุดเด่น 4 รายการ
