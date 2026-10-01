*** Settings ***
Documentation     Product TC_PROD_003-007 (TC_PROD_001-002 อยู่ใน test.robot แล้ว)
Resource          ../resources/keyword.robot
Suite Setup       Login As Valid User
Suite Teardown    Close Browser Session

*** Test Cases ***
TC_PROD_003 เพิ่มสินค้าโดยใส่ราคาติดลบ
    [Documentation]    Spec: ใส่ราคาทุน = -50 ต้องแจ้งเตือนไม่อนุญาตให้บันทึก (ระบบจริงบั๊กยอมให้บันทึก → test นี้ต้อง FAIL ตาม spec)
    [Tags]    Product
    Go To Products Page
    Delete All Products By Code    P_NEG
    Fill Product Form    P_NEG    สินค้าทดสอบราคาลบ    ทดสอบ    ชิ้น    -50    100    10
    Click Add Product Button
    Sleep    1s
    ${found}=    Find Product In Table By Code    P_NEG
    Should Not Be True    ${found}    msg=ระบบต้องปฏิเสธการบันทึกราคาติดลบ -50
    Delete All Products By Code    P_NEG

TC_PROD_004 เพิ่มสินค้าโดยเว้นว่างชื่อสินค้า
    [Documentation]    เว้นว่างช่องชื่อสินค้า กดบันทึก ต้องแจ้งเตือนให้กรอก
    [Tags]    Product
    Go To Products Page
    Input Text    id=code    P_TEST
    Input Text    id=category    ทดสอบ
    Input Text    id=unit    ชิ้น
    Input Text    id=cost_price    100
    Input Text    id=sell_price    150
    Input Text    id=quantity    10
    Click Element    css=#productForm button[type="submit"]
    ${current_url}=    Get Location
    Should Be Equal    ${current_url}    ${BASE_URL}/    msg=ต้องยังอยู่หน้าสินค้า
    ${is_valid}=    Execute Javascript
    ...    return document.getElementById('name').validity.valid;
    Should Not Be True    ${is_valid}    msg=name field ต้องไม่ valid เมื่อว่าง

TC_PROD_005 แก้ไขข้อมูลสินค้า
    [Documentation]    แก้ไขสินค้า P0001 เปลี่ยนจำนวนเป็น 150
    [Tags]    Product
    Go To Products Page
    Wait Until Element Is Visible    id=productList
    Click Edit Button By Code    P0001
    Wait Until Element Is Visible    id=editModal    timeout=5s
    Clear Element Text    id=edit_quantity
    Input Text    id=edit_quantity    150
    Click Element    css=.btn-save
    Sleep    1s
    ${qty}=    Get Product Quantity From Table    P0001
    Should Be Equal    ${qty}    150    msg=จำนวนสินค้า P0001 ต้องเป็น 150

TC_PROD_006 ลบรายการสินค้า
    [Documentation]    ลบสินค้าที่เพิ่มมา P0010 ต้องหายจากตาราง (มี pop-up ยืนยัน "ยืนยันการลบสินค้านี้?")
    [Tags]    Product
    Go To Products Page
    Wait Until Element Is Visible    id=productList
    ${found}=    Find Product In Table By Code    P0010
    Run Keyword If    not ${found}    Fill Product Form    P0010    ปูนฉาบ    ปูนซีเมนต์    ถุง    100    130    50
    Run Keyword If    not ${found}    Click Add Product Button
    Run Keyword If    not ${found}    Sleep    1s
    Delete All Products By Code    P0010
    Reload Page
    Wait Until Element Is Visible    id=productList    timeout=10s
    ${found_after}=    Find Product In Table By Code    P0010
    Should Not Be True    ${found_after}    msg=สินค้า P0010 ต้องถูกลบแล้ว

TC_PROD_007 แก้ไขรหัสสินค้าซ้ำกับรายการอื่น
    [Documentation]    Spec: แก้รหัส A ให้ตรงกับ B ต้องแจ้งเตือนรหัสซ้ำและปฏิเสธ (ระบบจริงบั๊กยอมให้ซ้ำ → test นี้ต้อง FAIL ตาม spec)
    [Tags]    Product
    Go To Products Page
    Wait Until Element Is Visible    id=productList
    ${has_p0010}=    Find Product In Table By Code    P0010
    Run Keyword If    not ${has_p0010}    Fill Product Form    P0010    ปูนฉาบ    ปูนซีเมนต์    ถุง    100    130    50
    Run Keyword If    not ${has_p0010}    Click Add Product Button
    Run Keyword If    not ${has_p0010}    Sleep    1s
    Edit Duplicate Code
    ${dup_count_p0001}=    Count Products By Code    P0001
    Should Be True    ${dup_count_p0001} <= 1    msg=ระบบต้องปฏิเสธการบันทึกรหัสซ้ำ P0001
