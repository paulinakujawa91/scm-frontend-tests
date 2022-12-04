*** Settings ***

Library   SeleniumLibrary
Variables  ../locators/home_page_locators.py
Variables  ../locators/autosalon_details_locators.py

*** Keywords ***

Submit consent if displaying
    Wait Until Element Is Visible   ${accept_all_consents}  timeout=5
    click button    ${accept_all_consents}

Click on 'wybierz swój samochód' tab
    Wait Until Element Is Visible   ${select_your_car_tab}  timeout=5
    click element   ${select_your_car_tab}

