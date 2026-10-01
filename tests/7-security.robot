*** Settings ***
Documentation     Test Cases สำหรับความปลอดภัย (Security)
Resource          ../resources/keyword.robot
Suite Teardown    Close Browser Session

*** Test Cases ***
TC_SEC_001 เรียกใช้ Product API โดยไม่ล็อกอิน
    [Documentation]    ส่ง Request GET /api/products โดยไม่ล็อกอิน ต้องคืน 401
    [Tags]    Security
    Open Browser To Login Page
    ${result}=    Execute Async Javascript
    ...    const callback = arguments[arguments.length - 1];
    ...    fetch('/api/products', {credentials: 'include'})
    ...        .then(r => r.json().then(body => callback({status: r.status, body: body})))
    ...        .catch(e => callback({status: 0, body: e.toString()}));
    Should Be Equal As Numbers    ${result}[status]    401    msg=ต้องคืน HTTP 401
    Should Be Equal    ${result}[body][message]    กรุณาเข้าสู่ระบบก่อน    msg=ข้อความต้องตรง

TC_SEC_002 เรียกใช้ Withdraw API โดยไม่ล็อกอิน
    [Documentation]    Spec: POST /api/stock/withdraw โดยไม่ล็อกอินต้อง 401 (spec ระบุ Failed: ยิงผ่าน URL เบราว์เซอร์ตรงๆ ได้แค่ GET)
    [Tags]    Security
    Open Browser To Login Page
    Go To    ${BASE_URL}/api/stock/withdraw
    Sleep    1s
    ${body}=    Get Text    css=body
    Should Contain    ${body}    กรุณาเข้าสู่ระบบก่อน    msg=ต้องคืน 401 กรุณาเข้าสู่ระบบก่อน (GET ตรงๆ จะไม่ได้ 401 → FAIL ตาม spec)
    # วิธีที่ถูกต้อง (fetch POST ตรงจะได้ 401 PASS) เก็บไว้เป็น comment:
    # ${result}=    Execute Async Javascript
    # ...    const callback = arguments[arguments.length - 1];
    # ...    fetch('/api/stock/withdraw', {method: 'POST', headers: {'Content-Type': 'application/json'}, body: JSON.stringify({product_id: 1, quantity: 1}), credentials: 'include'})
    # ...        .then(r => r.json().then(body => callback({status: r.status, body: body})))
    # ...        .catch(e => callback({status: 0, body: e.toString()}));
    # Should Be Equal As Numbers    ${result}[status]    401
