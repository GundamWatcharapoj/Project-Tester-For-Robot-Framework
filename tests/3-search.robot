*** Settings ***
Documentation     Test Cases สำหรับการค้นหาสินค้า (Search)
Resource          ../resources/keyword.robot
Suite Setup       Login As Valid User
Suite Teardown    Close Browser Session

*** Test Cases ***
TC_SRCH_001 ค้นหาสินค้าด้วยรหัสสินค้า
    [Documentation]    ค้นหาด้วยรหัส P0002 ตารางแสดงเฉพาะรายการที่มีรหัส P0002
    [Tags]    Search
    Go To Products Page
    Input Text    id=searchInput    P0002
    Click Element    css=.btn-search
    Wait Until Element Is Visible    id=productList
    Sleep    1s
    ${row_count}=    Get Element Count    css=#productList tr
    Should Be True    ${row_count} >= 1    msg=ต้องพบสินค้าอย่างน้อย 1 รายการ
    Verify All Rows Contain Text    P0002

TC_SRCH_002 ค้นหาสินค้าด้วยชื่อสินค้า
    [Documentation]    ค้นหาด้วยคำว่า "ปูนซีเมนต์" ตารางแสดงเฉพาะรายการที่มีคำว่า "ปูนซีเมนต์"
    [Tags]    Search
    Go To Products Page
    Input Text    id=searchInput    ปูนซีเมนต์
    Click Element    css=.btn-search
    Wait Until Element Is Visible    id=productList
    Sleep    1s
    ${row_count}=    Get Element Count    css=#productList tr
    Should Be True    ${row_count} >= 1    msg=ต้องพบสินค้าอย่างน้อย 1 รายการ
    Verify All Rows Contain Text    ปูนซีเมนต์

TC_SRCH_003 ค้นหาสินค้าด้วยหมวดหมู่
    [Documentation]    ค้นหาสินค้าด้วยหมวดหมู่ "อิฐและบล็อก" ตารางแสดงเฉพาะสินค้าในหมวดหมู่นั้น
    [Tags]    Search
    Go To Products Page
    Input Text    id=searchInput    อิฐและบล็อก
    Click Element    css=.btn-search
    Wait Until Element Is Visible    id=productList
    Sleep    1s
    ${row_count}=    Get Element Count    css=#productList tr
    Should Be True    ${row_count} >= 1    msg=ต้องพบสินค้าอย่างน้อย 1 รายการในหมวดอิฐและบล็อก
    Verify All Rows Contain Category    อิฐและบล็อก

TC_SRCH_004 ค้นหาด้วยคำที่ไม่พบในระบบ
    [Documentation]    ค้นหาด้วยคำ "xyz123" ตารางไม่พบข้อมูล แสดง "ยังไม่มีข้อมูลสินค้าในระบบ"
    [Tags]    Search
    Go To Products Page
    Input Text    id=searchInput    xyz123
    Click Element    css=.btn-search
    Wait Until Element Is Visible    id=productList
    Element Should Contain    id=productList    ยังไม่มีข้อมูลสินค้าในระบบ
