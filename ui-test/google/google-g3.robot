*** Settings ***
Library    SeleniumLibrary
Resource    resource-g3.robot

*** Test Cases ***
Test search keyword and verify search result on google
	พิมพ์
	พิมพ์คำค้น
	กด Enter
	ตรวจสอบผลการค้นหา

