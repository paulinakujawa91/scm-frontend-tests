*** Settings ***

Library   SeleniumLibrary
Library   String
Variables  ../locators/home_page_locators.py
Variables  ../locators/autosalon_details_locators.py

*** Keywords ***

Order by 'Cena pojazdu rosnąco'
    Wait Until Element Is Visible   ${sorting_input}    timeout=5
    Click element   ${sorting_input}
    Click element   ${sorting_by_ascending}

Compare elements by ascending
    Sleep   5
    Wait Until Element Is Visible   ${block_cars_details}   timeout=10
    ${count_rates}=     Get element count   ${rate}
    ${previews_rate}=   Set variable    0.0
    FOR   ${i}  IN RANGE  10
        IF   ${i} == 0  CONTINUE
        Log  ${previews_rate}
        ${str} =   Catenate    SEPARATOR=  ${rate}  [   ${i}    ]
        ${actual_rate}=     Get text        ${str}
        ${actual_rate}=     Replace String  ${actual_rate}  ,   .
        ${actual_rate}=     Convert to number   ${actual_rate}

         IF   ${i} == 1
            ${previews_rate}=  Set variable   ${actual_rate}
            CONTINUE
        END
        IF   ${previews_rate} <= ${actual_rate}
             ${previews_rate}=  Set variable   ${actual_rate}
             CONTINUE
        END
    Fail    "Not all rates are sorted"
    END

Order by 'Cena pojazdu malejąco'
    Wait Until Element Is Visible   ${sorting_input}    timeout=5
    Click element   ${sorting_input}
    Click element   ${sorting_by_descending}

Compare elements by descending
    Sleep   5
    Wait Until Element Is Visible   ${block_cars_details}   timeout=10
    ${count_rates}=     Get element count   ${rate}
    ${previews_rate}=   Set variable    0.0
    FOR   ${i}  IN RANGE  10
        IF   ${i} == 0  CONTINUE

        Log  ${previews_rate}
        ${str} =   Catenate    SEPARATOR=  ${rate}  [   ${i}    ]
        ${actual_rate}=     Get text        ${str}
        ${actual_rate}=     Replace String  ${actual_rate}  ,   .
        ${actual_rate}=     Convert to number   ${actual_rate}

        IF   ${i} == 1
            ${previews_rate}=  Set variable   ${actual_rate}
            CONTINUE
        END
        IF   ${previews_rate} >= ${actual_rate}
             ${previews_rate}=  Set variable   ${actual_rate}
             CONTINUE
        END
    Fail    "Not all rates are sorted"
    END

Order by 'Liczba pojazdów'
    [Arguments]  ${Counts_elements_on_page}
    Sleep   5
    Wait Until Element Is Visible   ${block_cars_details}   timeout=10
    Click element   ${count_of_cars_input}
    ${X_PATH_FOR_ELEMENT}=  Replace string  ${elements_on_page}  N  ${Counts_elements_on_page}
    Click element   ${X_PATH_FOR_ELEMENT}

check for correct displaying vehicles per page
    [Arguments]  ${expected_vehicles_per_page}
    Sleep   5
    Wait Until Element Is Visible   ${block_cars_details}   timeout=10
    ${displayed_car}=     Get element count   ${block_cars_details}

    ${displayed_car}=     Convert to number   ${displayed_car}
    ${expected_vehicles_per_page}=     Convert to number   ${expected_vehicles_per_page}

    Should be true  ${expected_vehicles_per_page} >= ${displayed_car}

Find 'Status pojazdu' field
    Wait Until Element Is Visible   ${block_cars_details}   timeout=10
    Click element   ${status_car_dropdown}

Select status
    [Arguments]  ${status_car}
    ${X_PATH_FOR_ELEMENT}=  Replace string      ${status_car_dropdown_value}  N   ${status_car}
    Wait Until Element Is Visible   ${X_PATH_FOR_ELEMENT}   timeout=10
    Click element       ${X_PATH_FOR_ELEMENT}

Check for correct displaying vehicles status
    [Arguments]  ${expected_label}
    Sleep  5
    Wait Until Element Is Visible   ${block_cars_details}   timeout=10
    FOR   ${i}  IN RANGE  10
        IF   ${i} == 0  CONTINUE

        Log     ${status_car_label}
        ${str} =   Catenate    SEPARATOR=  ${status_car_label}  [   ${i}    ]
        Log     {$str}
        ${status_label}=    Get text    ${str}
        Should Be Equal As Strings   ${expected_label}      ${status_label}
    END