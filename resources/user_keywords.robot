*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Given the API endpoint ${string}
    Set Test Variable    ${API_ENDPOINT}    ${string}

When I send a requet to GET User detail with userId ${value}
    Create Session    reqres    ${API_ENDPOINT}    verify=true
    ${response}=    GET On Session    reqres    /users/${value}
    Log    ${response}
    Set Test Variable    ${response}

When I send a requet to Create User with name ${name} and job ${job}
    Create Session    reqres    ${API_ENDPOINT}    verify=true
    ${response}=    POST On Session    reqres    /users    {"name": ${name}, "job": ${job}}
    Log    ${response.json()['id']}
    Set Test Variable    ${response}

Then the response status code should be ${status_code}
    Should Be Equal As Numbers    ${response.status_code}    ${status_code}

And the response body should contain data User
    ${user_data}=    Set Variable    ${response.json()['data']}
    Should Be Equal As Numbers    ${user_data['id']}    2
    Should Be Equal    ${user_data['email']}    janet.weaver@reqres.in
    Should Be Equal    ${user_data['first_name']}    Janet
    Should Be Equal    ${user_data['last_name']}    Weaver
    Should Be Equal    ${user_data['avatar']}    https://reqres.in/img/faces/2-image.jpg

And the response should contain an ID and a creation timestamp
    Should Not Be Empty    ${response.json()['id']}
    Should Not Be Empty    ${response.json()['createdAt']}
