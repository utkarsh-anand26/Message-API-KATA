Feature: Create a new message

  @PostMsg
  Scenario Outline: Create a message with valid data
    Given the endpoint "https://automationintesting.online/message/"
    When customer sends a POST request with the following data:
      | name      | email               | phone         | subject        | description                |
      | <name>    | <email>             | <phone>       | <subject>      | <description>              |
    Then the response status code should be 201
    And the response should contain a valid messageId
    And the response should match the JSON schema

    Examples:
      | name      | email                 | phone         | subject                  | description                       |
      | Utkarsh   | Utkarsh@hotmail.com   | 432655452876  | Late arrival for checkin | Due to delayed flight the arrival time will be extended       |
      | Mario 1   | Mario1@gmail.com      | 93843792811   | Request for extra bed    | An extra bed for the kid. |

  @Error
  Scenario Outline: Fail to create a message with empty values
    Given the endpoint "https://automationintesting.online/message/"
    When customer sends a POST request with the following invalid data:
      """
      {
        "name": "<name>",
        "email": "<email>",
        "phone": "<phone>",
        "subject": "<subject>",
        "description": "<description>"
      }
      """
    Then the response status code should be <statusCode>
    And the response should contain an error message "<errorMessage>"

    Examples:
      | name   | email           | phone       | subject      | description                           | statusCode | errorMessage                                    |
      |        | utkarsh@ut.com  | 12345678901 | Tests        | Dummy test message for error case     | 400        | Name may not be blank                           |
      | George |                 | 12345678901 | Tests        | Dummy test message for error case     | 400        | Email may not be blank                          |
      | George | Test@test.com   |    93812    | late arrival | Flight Delayed due to bad weather     | 400        | Phone must be between 11 and 21 characters.     |
      | Philip | philip@test.com | 12345678901 | Test         | Description                           | 400        | Subject must be between 5 and 100 characters.   |
      | Philip | philip@test.com | 12345678901 | Error Test   | Message                               | 400        | Message must be between 20 and 2000 characters. |
      | Alina  | alina@.com      | 12345678901 | Error Test   | Dummy Message to test email error     | 400        | must be a well-formed email address             |
      | George | Test@test.com   |             | late arrival | Flight Delayed                        | 400        | Phone may not be blank|
