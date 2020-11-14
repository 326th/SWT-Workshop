*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Test Cases ***
Test search keyword and verify search result on google
	พิมพ์ google.com
	พิมพ์คำค้น USElection2020
	กด Enter
	ตรวจสอบ US Election 2020 - BBC News

*** Keywords ***
พิมพ์ google.com
	Open Browser    https://google.com    chrome

พิมพ์คำค้น USElection2020
	Input Text    name:q    USElection2020

กด Enter
	Press Keys    name:q    RETURN

ตรวจสอบ US Election 2020 - BBC News
	Page Should Contain    US Election 2020 - BBC News