*** Settings ***
Documentation     Test Cases สำหรับการเบิกสินค้า (Withdraw)
Resource          ../resources/keyword.robot
Suite Setup       Login As Valid User
Suite Teardown    Close Browser Session

*** Test Cases ***
TC_WDW_001 เบิกสินค้าจำนวนไม่เกินสต๊อก
    [Documentation]    เบิกสินค้าปูนซีเมนต์ผสม ตราเสือ (50 กก.) จำนวน 5 ระบบแสดง "เบิกสินค้าสำเร็จ"
    [Tags]    Withdraw
    Go To Withdraw Page
    Select Product By Name    ปูนซีเมนต์ผสม
    Input Text    id=quantity    5
    Click Element    css=#withdrawForm button[type="submit"]
    Wait Until Element Is Visible    id=successMsg    timeout=5s
    Element Should Contain    id=successMsg    บันทึกการเบิกสินค้าเรียบร้อยแล้ว

TC_WDW_002 เบิกสินค้าเกินจำนวนที่มีในสต๊อก
    [Documentation]    เบิกสินค้าเหล็กเส้นข้ออ้อย 12mm จำนวน 10 (สต๊อกมี 5) แสดงเตือน "สต๊อกไม่พอ"
    [Tags]    Withdraw
    Go To Withdraw Page
    Select Product By Name    เหล็กเส้นข้ออ้อย
    Input Text    id=quantity    10
    Click Element    css=#withdrawForm button[type="submit"]
    Wait Until Element Is Visible    id=errorMsg    timeout=5s
    Element Should Contain    id=errorMsg    จำนวนที่เบิกเกินกว่าสินค้าที่มีอยู่ในคลัง

TC_WDW_003 เบิกสินค้าด้วยจำนวนติดลบ
    [Documentation]    กรอกจำนวน -2 ระบบแจ้งเตือนให้กรอกข้อมูลถูกต้อง (min=1)
    [Tags]    Withdraw
    Go To Withdraw Page
    Select Product By Name    ปูนซีเมนต์ผสม
    Input Text    id=quantity    -2
    ${is_valid}=    Execute Javascript
    ...    return document.getElementById('quantity').validity.valid;
    Should Not Be True    ${is_valid}    msg=จำนวน -2 ต้องไม่ valid (min=1)

TC_WDW_004 กดเบิกสินค้าโดยไม่เลือกสินค้า
    [Documentation]    ไม่เลือกสินค้า กดเบิก ระบบไม่ทำรายการ
    [Tags]    Withdraw
    Go To Withdraw Page
    Input Text    id=quantity    10
    Click Element    css=#withdrawForm button[type="submit"]
    ${selected}=    Get Value    id=product_id
    Should Be Empty    ${selected}    msg=ต้องไม่มีสินค้าถูกเลือก

TC_WDW_005 ระบุหมายเหตุในการเบิกสินค้า
    [Documentation]    เบิกสินค้าปูนซีเมนต์ผสม ตราเสือ จำนวน 2 พร้อมระบุหมายเหตุ "ใช้ก่อสร้างหน้างาน A"
    [Tags]    Withdraw
    Go To Withdraw Page
    Select Product By Name    ปูนซีเมนต์ผสม
    Input Text    id=quantity    2
    Input Text    id=note    ใช้ก่อสร้างหน้างาน A
    Click Element    css=#withdrawForm button[type="submit"]
    Wait Until Element Is Visible    id=successMsg    timeout=5s
    Element Should Contain    id=successMsg    บันทึกการเบิกสินค้าเรียบร้อยแล้ว
    Go To History Page
    Wait Until Element Is Visible    id=historyList
    Element Should Contain    id=historyList    ใช้ก่อสร้างหน้างาน A

TC_WDW_006 ตรวจสอบจำนวนสต๊อกหลังเบิก
    [Documentation]    เบิกสินค้าปูนซีเมนต์ผสม ตราเสือ 5 ชิ้น แล้วตรวจสอบว่าจำนวนคงเหลือลดลง
    [Tags]    Withdraw
    Go To Withdraw Page
    Select Product By Name    ปูนซีเมนต์ผสม
    ${stock_before}=    Get Stock Hint Quantity
    Input Text    id=quantity    5
    Click Element    css=#withdrawForm button[type="submit"]
    Wait Until Element Is Visible    id=successMsg    timeout=5s
    Go To Withdraw Page
    Select Product By Name    ปูนซีเมนต์ผสม
    ${stock_after}=    Get Stock Hint Quantity
    ${expected}=    Evaluate    int(${stock_before}) - 5
    Should Be Equal As Numbers    ${stock_after}    ${expected}    msg=สต๊อกหลังเบิกไม่ถูกต้อง
