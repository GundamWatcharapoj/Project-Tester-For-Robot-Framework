*** Settings ***
Documentation     Test Cases สำหรับหน้าประวัติเบิกสินค้า (History)
Resource          ../resources/keyword.robot
Suite Setup       Login As Valid User
Suite Teardown    Close Browser Session

*** Test Cases ***
TC_HIST_001 ตรวจสอบการแสดงผลหน้าประวัติ
    [Documentation]    ตรวจสอบว่าหน้าประวัติแสดงรายการเรียงตามเวลาล่าสุด
    [Tags]    History
    Go To History Page
    Wait Until Element Is Visible    id=historyList
    ${row_count}=    Get Element Count    css=#historyList tr
    Run Keyword If    ${row_count} > 1    Verify History Sorted By Latest
    ...    ELSE    Log    มีรายการน้อยกว่า 2 รายการ ข้ามการตรวจสอบลำดับ

TC_HIST_002 ตรวจสอบชื่อผู้เบิกในประวัติ
    [Documentation]    ตรวจสอบว่าช่องผู้เบิกแสดงชื่อ admin ตรงตามผู้ใช้งาน
    [Tags]    History
    Go To History Page
    Wait Until Element Is Visible    id=historyList
    ${row_count}=    Get Element Count    css=#historyList tr
    Run Keyword If    ${row_count} > 0    Verify Withdrawn By Column Exists
    ...    ELSE    Fail    msg=ไม่มีรายการในประวัติให้ตรวจสอบ

TC_HIST_003 ตรวจสอบความถูกต้องของข้อมูลประวัติ
    [Documentation]    ตรวจสอบว่าแต่ละแถวแสดง รหัส, ชื่อสินค้า, จำนวน, วันเวลา ครบถ้วน
    [Tags]    History
    Go To History Page
    Wait Until Element Is Visible    id=historyList
    ${row_count}=    Get Element Count    css=#historyList tr
    Run Keyword If    ${row_count} > 0    Verify History Row Completeness
    ...    ELSE    Fail    msg=ไม่มีรายการในประวัติให้ตรวจสอบ
