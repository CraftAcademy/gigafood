Feature: As Giga-Food
  In order to make a decision to start an order
  I like to have three options approve, cancel and a input filed with transport size

Background:
  Given the following orders exist:
  | order_id | user_email           | order_date |
  | 1        | doe@example.com  | 2017-09-08 |
  | 2        | john@example.com | 2017-09-07 |

Scenario:
  Given I am on the "View order" page
  Then I should see a input field "Boxes"
  And I should see button "Approve"
  And I should see button "Cancel"

Scenario: Approve
  When I fill in "Boxes" with "2"
  And press button "Approve"
  Then the "order status" should be set to "confirmed"

Scenario: Cancel order
  When I press button "Cancel"
  Then A email should be sent to "butthole@example.com"
