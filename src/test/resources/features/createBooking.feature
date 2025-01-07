Feature: Hotel room Booking
  As a user I want to book a hotel room

Scenario Outline: Create successful hotel booking with required data
  Given user is at the booking page with url "https://automationintesting.online/booking/"
  When user sends a post http request with the following data:
    | firstname  | lastname | email   | phone   | roomid   | depositpaid   | checkin      | checkout     |
    | <firstname>|<lastname>| <email> | <phone> | <roomid> | <depositpaid> | <checkin>    | <checkout>   |
  Then the response status code should be 201
  And the response should contain:
    | firstname  | lastname | email   | phone   | roomid   | depositpaid   | checkin      | checkout     |
    | <firstname>|<lastname>| <email> | <phone> | <roomid> | <depositpaid> | <checkin>    | <checkout>   |

  Examples:
    | firstname  | lastname | email   | phone   | roomid   | depositpaid   | checkin      | checkout     |
    | Alexee  | lastname | email   | phone   | roomid   | depositpaid   | checkin      | checkout     |