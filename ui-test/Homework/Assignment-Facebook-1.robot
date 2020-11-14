*** Settings ***
Library    SeleniumLibrary
Resource    Assignment-Facebook-1-resource.robot

*** Test Cases ***
Facebook post
    open facebook
    login
    click post prompt
    write post
    post the word
    check post

*** Keywords ***
open facebook
    Open Browser    https://www.facebook.com    chrome

login
    Input Text    email    ${USERNAME}
    Input Password    pass    ${PASSWORD}
    Click Button    name:login

click post prompt
    Click Button    Xpath:/html/body/div[1]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div/div[2]/div/div/div[3]/div/div[2]/div/div/div/div[1]/div

write post
    Input Text    Xpath:/html/body/div[1]/div/div[1]/div[1]/div[4]/div/div/div[1]/div/div[2]/div/div/div/form/div/div[1]/div/div/div[2]/div[1]/div[1]/div[1]/div/div/div/div/div[2]/div/div/div/div    ${POST_TEXT}

post the word
    Press Keys    Xpath:/html/body/div[1]/div/div[1]/div[1]/div[4]/div/div/div[1]/div/div[2]/div/div/div/form/div/div[1]/div/div/div[2]/div[1]/div[1]/div[1]/div/div/div/div/div[2]/div/div/div/div    RETURN

check post
    Page Should Contain    ${POST_TEXT}
    Close Browser