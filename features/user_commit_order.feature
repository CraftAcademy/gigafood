@javascript
Feature: Allow end user to commit order
  As an end-user
  In order to complete my order
  I need to submit the order.

  Background:
    Given the following dishes exist:
      | name         | description             | price | min_quantity |
      | Dish 1       | Description for Dish 1  | 100   |  10          |

  Scenario: User can manipulate quantity with + and - buttons
    When I go to the landing page
    And I click on + for "Dish 1"
    And I click on "Next"
    And I fill in "order_delivery_date" with "2017-11-10"

    And I fill in "order_delivery_name" with "Hungry corp Inc"
    And I fill in "order_delivery_address" with "Street 42"
    And I fill in "order_delivery_postal_code" with "123 45"
    And I fill in "order_delivery_city" with "Town"
    And I fill in "order_delivery_floor" with "3"
    And I fill in "order_delivery_door_code" with "1111"
    And I fill in "order_delivery_contact_name" with "John Doe"
    And I fill in "order_delivery_contact_phone_number" with "555 123 45 67"
    And I fill in "order_billing_name" with "John Doe"
    And I fill in "order_billing_company" with "Hungry corp Inc"
    And I fill in "order_billing_org_nr" with "19210713-1444"
    And I fill in "order_billing_address" with "Street 42"
    And I fill in "order_billing_postal_code" with "123 45"
    And I fill in "order_billing_city" with "Town"
    And I fill in "order_billing_phone" with "555 123 55 11"
    And I fill in "order_billing_email" with "invoice@hungrycorp.com"
    And I click on "Submit Order"
    Then I should see "Thanks!"
