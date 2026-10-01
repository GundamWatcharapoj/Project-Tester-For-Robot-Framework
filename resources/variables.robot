*** Variables ***
# ===== Base (จาก Project-tester-robot-main/tests/resources/resource.robot) =====
${BASE_URL}             http://localhost:3000
${BROWSER}              Chrome
${TIMEOUT}              10s
${VALID_USERNAME}       admin
${VALID_PASSWORD}       123456

# ===== Alias เดิมกัน test.robot พัง =====
${USERNAME}               ${VALID_USERNAME}
${PASSWORD}               ${VALID_PASSWORD}
${LOGIN_URL}              ${BASE_URL}/login
${MANAGE_STORAGE_URL}     ${BASE_URL}/
${MANAGE__STORAGE_URL}    ${BASE_URL}/
${ABOUT_URL}              ${BASE_URL}/about
${HISTORY_URL}            ${BASE_URL}/history
${WITHDRAW_URL}           ${BASE_URL}/withdraw

# ===== Message เดิม =====
${NAME_WEB_MESSAGE}       TAFU WATSADU
${SUCCESS_MESSAGE}        ลบข้อมูลสำเร็จ
${MANAGE_STORGE_MESSAGE}  เพิ่มสินค้าใหม่

# ===== หน้า login =====
${INVALID_USERNAME}       wronguser
${INVALID_PASSWORD}       wrongpassword
${INVALID_USERNAME_MESSAGE}  ไม่พบชื่อผู้ใช้นี้
${INVALID_PASSWORD_MESSAGE}  รหัสผ่านไม่ถูกต้อง
${LOGOUT_BUTTON}          //*[@id="navbar-container"]/aside/div[2]/button

${USERNAME_INPUT}         id=username
${PASSWORD_INPUT}         id=password
${LOGIN_BUTTON}           css=#loginForm button[type="submit"]
${LOGIN_FORM}             id=loginForm
${ERROR_MSG}              id=errorMsg
${SUCCESS_MSG}            id=successMsg

# ===== หน้าคลังสินค้า (locator ใหม่แบบ id/css) =====
${SEARCH_INPUT}           id=searchInput
${SEARCH_BUTTON}          css=.btn-search
${PRODUCT_LIST}           id=productList
${TABLE_ROW_XPATH}        id=productList
${SAVE_PRODUCT_BUTTON}    css=#productForm button[type="submit"]
${PRODUCT_FORM}           id=productForm
${EDIT_MODAL}             id=editModal
${EDIT_QUANTITY_INPUT}    id=edit_quantity
${EDIT_CODE_INPUT}        id=edit_code
${BTN_SAVE}               css=.btn-save
${BTN_EDIT}               css=.btn-edit
${BTN_DEL}                css=.btn-del

${PRODUCT_CODE_INPUT}        id=code
${PRODUCT_NAME_INPUT}        id=name
${PRODUCT_CATEGORY_INPUT}    id=category
${UNIT_INPUT}                id=unit
${COST_PRICE_INPUT}          id=cost_price
${SELL_PRICE_INPUT}          id=sell_price
${QUANTITY_INPUT}            id=quantity

# ===== หน้าเบิกสินค้า (withdraw.robot) =====
${PRODUCT_ID_SELECT}      id=product_id
${WITHDRAW_QUANTITY}      id=quantity
${WITHDRAW_NOTE}          id=note
${STOCK_HINT}             id=stockHint
${WITHDRAW_SUBMIT}        css=#withdrawForm button[type="submit"]

# ===== หน้าประวัติ (history.robot) =====
${HISTORY_LIST}           id=historyList

# ===== Navigation (navigation.robot) =====
${NAV_WITHDRAW}           id=nav-withdraw
${NAV_HISTORY}            id=nav-history
${NAV_PRODUCTS}           id=nav-products

# ===== OLD xpath เก็บไว้กันอ้างอิง (ไม่ใช้แล้ว) =====
# OLD: ${USERNAME_INPUT} = xpath=/html/body/div/form/div[1]/input
# OLD: ${PASSWORD_INPUT} = xpath=/html/body/div/form/div[2]/div/input
# OLD: ${LOGIN_BUTTON} = xpath=/html/body/div/form/button
# OLD: ${SEARCH_INPUT_XPATH} = xpath=/html/body/main/div[2]/div/input
# OLD: ${CLEAR_BUTTON_XPATH} = xpath=/html/body/main/div[2]/div/button[2]
# OLD: ${SAVE_PRODUCT_BUTTON} = xpath=//*[@id="productForm"]/button
# OLD: ${DELETE_PRODUCT_BUTTON} = xpath=/html/body/main/div[2]/table/tbody/tr[1]/td[8]/div/button[2]
# OLD: ${EDIT_PRODUCT_BUTTON} = xpath=/html/body/main/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
# OLD: ${TABLE_ROW_XPATH} = xpath=/html/body/main/div[2]/table
# OLD: ${PRODUCT_CODE_INPUT} = xpath=//html/body/main/div[1]/form/div[1]/input
# OLD: ${PRODUCT_NAME_INPUT} = xpath=//html/body/main/div[1]/form/div[2]/input
# OLD: ${PRODUCT_CATEGORY_INPUT} = xpath=//html/body/main/div[1]/form/div[3]/input
# OLD: ${UNIT_INPUT} = xpath=//html/body/main/div[1]/form/div[4]/input
# OLD: ${COST_PRICE_INPUT} = xpath=//html/body/main/div[1]/form/div[5]/input
# OLD: ${SELL_PRICE_INPUT} = xpath=//html/body/main/div[1]/form/div[6]/input
# OLD: ${QUANTITY_INPUT} = xpath=//html/body/main/div[1]/form/div[7]/input
# OLD: ${RESEARCH_URL} = http://localhost/thesis/site/index.php (ไม่ได้ใช้แล้ว)
# OLD: ${BROWSER} = chrome / ${TIMEOUT} = 5s (เปลี่ยนเป็น Chrome / 10s ตามต้นแบบ)
