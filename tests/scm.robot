*** Settings ***
Documentation  Test scenarios for functional options on car's leasing section: sorting, filtering, serching by calculate's parameters
...            and checking correct form for disable elements on page

Library  SeleniumLibrary
Resource    ../page_object/keywords/home_page.robot
Resource    ../page_object/keywords/autosalon_details_page.robot

Test Setup     Open Browser    ${URL}   ${BROWSER}
Test Teardown  Close All Browsers

*** Variables ***
${URL}              https://www.scmultirent.pl/
${BROWSER}          Chrome
${vehicles_per_page}  10
${status_dropdown_value}   Używany/poleasingowy
${status_car}     Używany

*** Test Cases ***
TC001 Sorting by ascend of rates for car's leasing
    Submit consent if displaying
    Click on 'wybierz swój samochód' tab
    Order by 'Cena pojazdu rosnąco'
    Compare elements by ascending

TC002 Sorting by descend of rates for car's leasing
    Submit consent if displaying
    Click on 'wybierz swój samochód' tab
    Order by 'Cena pojazdu malejąco'
    Compare elements by descending

TC003 Sorting by count of elements on page
    Submit consent if displaying
    Click on 'wybierz swój samochód' tab
    Order by 'Liczba pojazdów'  ${vehicles_per_page}
    Check for correct displaying vehicles per page     ${vehicles_per_page}

TC004 Filtering by vehicle status
    Submit consent if displaying
    Click on 'wybierz swój samochód' tab
    Find 'Status pojazdu' field
    Select status     ${status_dropdown_value}
    Check for correct displaying vehicles status  ${status_car}
