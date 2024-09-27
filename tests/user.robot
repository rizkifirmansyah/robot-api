*** Settings ***
Resource    ../resources/user_keywords.robot

*** Test Cases ***
Verify Get Detail User Successfully
  Given the API endpoint https://reqres.in/api
  When I send a requet to GET User detail with userId 2
  Then the response status code should be 200
  And the response body should contain data User

Verify Create User Successfully
  Given the API endpoint https://reqres.in/api
  When I send a requet to Create User with name "morpheus" and job "leader"
  Then the response status code should be 201
  And the response should contain an ID and a creation timestamp
