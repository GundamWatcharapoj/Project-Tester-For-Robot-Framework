*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     String
Resource    variables.robot

*** Keywords ***
# ===== ของเดิม (เก็บไว้กัน test.robot พัง) =====
Open Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

Login page
    [Arguments]    ${username}    ${password}
    Input Text      ${USERNAME_INPUT}    ${username}
    Input Text      ${PASSWORD_INPUT}    ${password}
    Click Element   ${LOGIN_BUTTON}

Add Product
    [Arguments]    ${product_code}    ${product_name}    ${product_category}    ${cost_price}    ${sell_price}    ${quantity}    ${unit}
    Input Text    ${PRODUCT_CODE_INPUT}        ${product_code}
    Input Text    ${PRODUCT_NAME_INPUT}        ${product_name}
    Input Text    ${PRODUCT_CATEGORY_INPUT}    ${product_category}
    Input Text    ${UNIT_INPUT}                ${unit}
    Input Text    ${COST_PRICE_INPUT}          ${cost_price}
    Input Text    ${SELL_PRICE_INPUT}          ${sell_price}
    Input Text    ${QUANTITY_INPUT}            ${quantity}
    Click Element    ${SAVE_PRODUCT_BUTTON}

# ===== ชุดใหม่จาก Project-tester-robot-main/tests/resources/resource.robot =====
Open Browser To Login Page
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}
    Wait Until Page Contains Element    id=username

Login As Valid User
    [Arguments]    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    Open Browser To Login Page
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    Click Element    css=#loginForm button[type="submit"]
    Wait Until Location Is    ${BASE_URL}/    timeout=${TIMEOUT}

Login Without Submit
    [Arguments]    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    Open Browser To Login Page
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}

Logout
    Execute Javascript    fetch('/api/logout', {method:'POST', credentials:'include'})
    Go To    ${BASE_URL}/login
    Wait Until Page Contains Element    id=username

Go To Products Page
    Go To    ${BASE_URL}/
    Wait Until Page Contains Element    id=searchInput

Go To Withdraw Page
    Go To    ${BASE_URL}/withdraw
    Wait Until Page Contains Element    id=product_id

Go To History Page
    Go To    ${BASE_URL}/history
    Wait Until Page Contains Element    id=historyList

Go To About Page
    Go To    ${BASE_URL}/about
    Wait Until Page Contains    เกี่ยวกับเรา

Fill Product Form
    [Arguments]    ${code}    ${name}    ${category}    ${unit}    ${cost_price}    ${sell_price}    ${quantity}
    Input Text    id=code    ${code}
    Input Text    id=name    ${name}
    Input Text    id=category    ${category}
    Input Text    id=unit    ${unit}
    Input Text    id=cost_price    ${cost_price}
    Input Text    id=sell_price    ${sell_price}
    Input Text    id=quantity    ${quantity}

Click Add Product Button
    Click Element    css=#productForm button[type="submit"]

Find Product In Table By Code
    [Arguments]    ${code}
    ${found}=    Execute Javascript
    ...    const rows = document.querySelectorAll('#productList tr');
    ...    for (let row of rows) {
    ...        if (row.textContent.includes('${code}')) return true;
    ...    }
    ...    return false;
    Return From Keyword    ${found}

Get Product Quantity From Table
    [Arguments]    ${code}
    ${qty}=    Execute Javascript
    ...    const rows = document.querySelectorAll('#productList tr');
    ...    for (let row of rows) {
    ...        if (row.textContent.includes('${code}')) {
    ...            const cells = row.querySelectorAll('td');
    ...            return cells[5].textContent.trim();
    ...        }
    ...    }
    ...    return null;
    Return From Keyword    ${qty}

Close Browser Session
    Close All Browsers

# ===== Helpers สำหรับ product/search/withdraw/history (ยกมาจาก Project-tester-robot-main) =====
Click Edit Button By Code
    [Arguments]    ${code}
    Execute Javascript
    ...    const rows = document.querySelectorAll('#productList tr');
    ...    for (let row of rows) {
    ...        if (row.textContent.includes('${code}')) {
    ...            row.querySelector('.btn-edit').click();
    ...            return;
    ...        }
    ...    }

Delete Product By Code
    [Arguments]    ${code}
    Execute Javascript
    ...    const rows = document.querySelectorAll('#productList tr');
    ...    for (let row of rows) {
    ...        if (row.textContent.includes('${code}')) {
    ...            row.querySelector('.btn-del').click();
    ...            return;
    ...        }
    ...    }
    Handle Alert    action=accept    timeout=5s
    Sleep    1s
    Wait Until Page Contains Element    id=productList    timeout=5s

Delete All Products By Code
    [Arguments]    ${code}
    FOR    ${i}    IN RANGE    10
        ${found}=    Find Product In Table By Code    ${code}
        Run Keyword If    not ${found}    Exit For Loop
        Delete Product By Code    ${code}
        Sleep    1s
    END

Count Products By Code
    [Arguments]    ${code}
    ${count}=    Execute Javascript
    ...    let c = 0;
    ...    for (let row of document.querySelectorAll('#productList tr')) {
    ...        if (row.textContent.includes('${code}')) c++;
    ...    }
    ...    return c;
    Return From Keyword    ${count}

Edit Duplicate Code
    Execute Javascript
    ...    const rows = document.querySelectorAll('#productList tr');
    ...    for (let row of rows) {
    ...        if (row.textContent.includes('P0010')) {
    ...            row.querySelector('.btn-edit').click();
    ...            return;
    ...        }
    ...    }
    Wait Until Element Is Visible    id=editModal    timeout=5s
    Clear Element Text    id=edit_code
    Input Text    id=edit_code    P0001
    Click Element    css=.btn-save
    Sleep    1s
    Log    ระบบยอมให้บันทึกรหัสซ้ำได้ (Known Issue)

Verify All Rows Contain Text
    [Arguments]    ${text}
    ${cells}=    Get WebElements    css=#productList tr
    FOR    ${cell}    IN    @{cells}
        ${cell_text}=    Get Text    ${cell}
        Should Contain    ${cell_text}    ${text}    msg=พบแถวที่ไม่มีคำว่า "${text}"
    END

Verify All Rows Contain Category
    [Arguments]    ${category}
    ${cells}=    Get WebElements    css=#productList td[data-label="หมวดหมู่"]
    FOR    ${cell}    IN    @{cells}
        ${text}=    Get Text    ${cell}
        Should Contain    ${text}    ${category}    msg=พบสินค้าที่ไม่ใช่หมวดหมู่ "${category}"
    END

Select Product By Name
    [Arguments]    ${name}
    ${found}=    Execute Javascript
    ...    const sel = document.getElementById('product_id');
    ...    for (let i = 0; i < sel.options.length; i++) {
    ...        if (sel.options[i].text.includes('${name}')) {
    ...            sel.selectedIndex = i;
    ...            sel.dispatchEvent(new Event('change'));
    ...            return true;
    ...        }
    ...    }
    ...    return false;
    Should Be True    ${found}    msg=ไม่พบสินค้า "${name}" ใน dropdown

Get Stock Hint Quantity
    Wait Until Element Is Visible    id=stockHint    timeout=5s
    Wait Until Keyword Succeeds    5s    500ms    Stock Hint Should Contain Number
    ${hint_text}=    Get Text    id=stockHint
    @{nums}=    Get Regexp Matches    ${hint_text}    \\d+
    Should Not Be Empty    ${nums}    msg=ไม่พบจำนวนสต๊อกใน stockHint: ${hint_text}
    Return From Keyword    ${nums}[0]

Stock Hint Should Contain Number
    ${hint_text}=    Get Text    id=stockHint
    Should Match Regexp    ${hint_text}    \\d+    msg=รอ stockHint โหลดตัวเลขสต๊อก

Verify History Sorted By Latest
    ${dates}=    Get WebElements    css=#historyList td[data-label="วันที่"]
    ${count}=    Get Length    ${dates}
    ${first_date}=    Get From List    ${dates}    0
    ${last_idx}=    Evaluate    ${count} - 1
    ${last_date}=    Get From List    ${dates}    ${last_idx}
    ${first_text}=    Get Text    ${first_date}
    ${last_text}=    Get Text    ${last_date}
    ${first_dt}=    Convert Thai Date To Datetime    ${first_text}
    ${last_dt}=    Convert Thai Date To Datetime    ${last_text}
    Should Be True    ${first_dt} >= ${last_dt}    msg=รายการล่าสุดควรอยู่บนสุด

Convert Thai Date To Datetime
    [Arguments]    ${thai_date}
    ${dt}=    Execute Javascript
    ...    const parts = '${thai_date}'.trim().split(' ');
    ...    const dateParts = parts[0].split('/');
    ...    const timeParts = parts.length > 1 ? parts[1].split(':') : ['00','00'];
    ...    const yearCE = parseInt(dateParts[2]) - 543;
    ...    return new Date(yearCE, parseInt(dateParts[1])-1, parseInt(dateParts[0]), parseInt(timeParts[0]), parseInt(timeParts[1])).getTime();
    Return From Keyword    ${dt}

Verify Withdrawn By Column Exists
    ${cells}=    Get WebElements    css=#historyList td[data-label="ผู้เบิก"]
    FOR    ${cell}    IN    @{cells}
        ${text}=    Get Text    ${cell}
        Should Not Be Empty    ${text}    msg=พบคอลัมน์ผู้เบิกว่างเปล่า
    END

Verify History Row Completeness
    ${row_count}=    Get Element Count    css=#historyList tr
    FOR    ${i}    IN RANGE    ${row_count}
        ${cell_count}=    Execute Javascript
        ...    return document.querySelectorAll('#historyList tr')[${i}].querySelectorAll('td').length;
        Should Be Equal As Numbers    ${cell_count}    6    msg=แถวที่ ${i+1} ต้องมี 6 คอลัมน์ (วันที่, รหัส, ชื่อสินค้า, จำนวน, หมายเหตุ, ผู้เบิก)
    END
