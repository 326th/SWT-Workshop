*** Variables ***
${URL}    https://google.com
${BROWSER}    chrome
${SEARCH_WORD}    USElection2020
${EXPECTED_RESULT}    US Election 2020 - BBC News

*** Keywords ***
พิมพ์
	Open Browser    ${URL}    ${BROWSER}

พิมพ์คำค้น
	Input Text    name:q    ${SEARCH_WORD}

กด Enter
	Press Keys    name:q    RETURN

ตรวจสอบผลการค้นหา
	Page Should Contain    ${EXPECTED_RESULT}
	Close Browser
