*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

*** Variables ***

*** Test Cases ***
user ซื้อของเล่นให้ลูกสาว เลือกวิธีจัดส่งเป็น kerry ชำระเงินด้วยบัตรเครดิต visa และชำระเงินสำเร็จ
    แสดงสินค้า
    แสดงรายละเอียดสินค้า
    ระบุจำนวนสินค้าที่ซื้อ
    นำสินค้าใส่ตระก้า
    ยืนยันการสั่งซื้อและชำระเงินด้วยบัตรเครดิตวีซ่าคาร์ด
    ขอบคุณ

*** Keywords ***
แสดงสินค้า
    Open Browser    https://www.dminer.in.th/Product-list.html    chrome
    Page Should Contain    43 Piece Dinner Set
    Element Should Contain    locator=id:productPrice-1    expected=12.95 USD

แสดงรายละเอียดสินค้า
    Click Element    locator=viewMore-1
    Wait Until Element Contains    locator=id:productName    text=43 Piece dinner Set
    Element Should Contain    locator=id:productBrand    expected=CoolKidz
    Element Should Contain    locator=id:productPrice    expected=12.95 USD

ระบุจำนวนสินค้าที่ซื้อ
    Input Text    locator=id:productQuantity    text=1

นำสินค้าใส่ตระก้า
    Click Element    locator=addToCart
    Wait Until Element Contains    locator=id:receiverName    text=ณัฐญา ชุติบุตร
    Element Should Contain    locator=id:recevierAddress    expected=405/37 ถ.มหิดล ต.ท่าศาลา อ.เมือง จ.เชียงใหม่ 50000
    Element Should Contain    locator=id:recevierPhonenumber    expected=0970809292
    Element Should Contain    locator=id:totalProductPrice    expected=12.95 USD
    Element Should Contain    locator=id:productName-1    expected=43 Piece dinner Set

ยืนยันการสั่งซื้อและชำระเงินด้วยบัตรเครดิตวีซ่าคาร์ด
    Click Element     locator=id:confirmPayment
    Wait Until Page Contains     เลขบัตร
    Input Text    id:cardNumber    text=471970059150995
    Input Text    id:expiredMonth    text=7
    Input Text    id:expiredYear    text=20
    Input Text    id:cvv    text=752
    Input Text    id:cardName    text=Karnwat Wongudom

ขอบคุณ
    Click Element     locator=id:Payment
    Wait Until Page Contains    วันเวลาที่ชำระเงิน 1/3/2563 13:30:00 หมายเลขคำสั่งซื้อ 8004359103 คุณสามารถติดตามสินค้าผ่านช่องทาง Kerry ด้วยหมายเลข 1785261900