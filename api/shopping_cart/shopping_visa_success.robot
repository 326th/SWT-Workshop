*** Settings ***
Library    RequestsLibrary
Suite Setup    Create Session    alias=shopping    url=https://dminer.in.th
*** Variables ***
&{HEADER}    Content-Type=application/json    Accept=application/json

*** Test Cases ***
user ซื้อของเล่นให้ลูกสาว เลือกวิธีจัดส่งเป็น kerry ชำระเงินด้วยบัตรเครดิต visa และชำระเงินสำเร็จ
    Search
    Product Detail    2
    Submit Order
    Confirm Payment

*** Keywords ***
Search    
    ${resp}=    Get Request    alias=shopping    uri=/api/v1/product
    Request Should Be Successful    ${resp}
    Should Be Equal    ${resp.json()['products'][1]['product_name']}    43 Piece dinner Set

Product Detail
    [Arguments]    ${product_id}
    ${resp}=    Get Request    alias=shopping    uri=/api/v1/product/${product_id}   headers=&{HEADER}
    Request Should Be Successful    ${resp}
    Should Be Equal As Integers    ${resp.json()['id']}    2
    Should Be Equal    ${resp.json()['product_name']}    43 Piece dinner Set
    Should Be Equal As Numbers    ${resp.json()['product_price']}    12.95
    Should Be Equal As Integers    ${resp.json()['quantity']}    10
    Should Be Equal    ${resp.json()['product_brand']}    CoolKidz

Submit Order
    ${post_body}=    To Json    {"cart" : [{ "product_id": 2,"quantity": 1}],"shipping_method" : "Kerry","shipping_address" : "405/37 ถ.มหิดล","shipping_sub_district" : "ต.ท่าศาลา","shipping_district" : "อ.เมือง","shipping_province" : "จ.เชียงใหม่","shipping_zip_code" : "50000","recipient_name" : "ณัฐญา ชุติบุตร","recipient_phone_number" : "0970809292"}
    ${resp}=    Post Request    alias=shopping    uri=/api/v1/order    headers=&{HEADER}    json=${post_body}
    Request Should Be Successful    ${resp}
    #Check order and total price
    Should Be Equal As Integers    ${resp.json()['order_id']}    8004359122
    Should Be Equal As Numbers    ${resp.json()['total_price']}    14.95
    #Set order and total price as variable
    ${ORDER_ID}=    Set Variable    ${resp.json()['order_id']} 
    ${TOTAL_PRICE}=    Set Variable    ${resp.json()['total_price']} 
    #Set as Global Variable
    Set Test Variable    ${ORDER_ID}
    Set Test Variable    ${TOTAL_PRICE}

Confirm Payment
    ${post_body}=    To Json    {"order_id": ${ORDER_ID}, "payment_type": "credit","type": "visa","card_number": "4719700591590995","cvv": "752","expired_month": 7,"expired_year": 20,"card_name": "Karnwat Wongudom","total_price": ${TOTAL_PRICE}}
    ${resp}=    Post Request    alias=shopping    uri=/api/v1/confirmPayment    headers=&{HEADER}    json=${post_body}
    Request Should Be Successful    ${resp}
    Should Be Equal As Strings    ${resp.json()["notify_message"]}    วันเวลาที่ชำระเงิน 1/3/2020 13:30:00 หมายเลขคำสั่งซื้อ ${ORDER_ID} คุณสามารถติดตามสินค้าผ่านช่องทาง Kerry หมายเลข 1785261900
