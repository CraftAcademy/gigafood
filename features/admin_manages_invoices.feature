Feature: Admin creates invoice
  As GigaFood
  In order to get payment for the order
  I need to generate a PDF invoice with order details and payment information


  Background:
    Given the following categories exist:
      | name    | description                |
      | Starter | Description for category 1 |

    And the following dishes exist:
      | name   | description            | price | min_quantity | category |
      | Dish 1 | Description for Dish 1 | 100   | 10           | Starter  |
      | Dish 2 | Description for Dish 2 | 200   | 10           | Starter  |
      | Dish 3 | Description for Dish 3 | 300   | 10           | Starter  |

    And the following orders exist:
      | billing_name | delivery_date    | billing_email          |
      | Bob Schmob   | 2017-11-20 12:00 | bob.schmob@example.com |
      | John Smith   | 2017-10-10 12:00 | john.smith@example.com |

    And an admin exists with email "admin@example.com" and password "password"
    And I'm loged in as admin user "admin@example.com"
    And I go to the dashboard


  Scenario: Admin generates an invoice
    Given "Bob Schmob"'s order contains:
      | dish_name | quantity |
      | Dish 1    | 10       |
      | Dish 2    | 20       |
    And I click on "Orders"
    And I press "View" for order "Bob Schmob"
    And I press "Generate Invoice"
    Then an invoice for the order should be created
    And the invoice should contain "Buyer contact: Bob Schmob"
    And the invoice should contain "Tax (VAT): 600 kr"
    And the invoice should contain "Total with VAT: 5,600 kr"

  @javascript
  Scenario: Admin views order
    Given an Invoice has been generated for "Bob Schmob"'s order
    And I press "View Invoice"
    Then I should see the invoice in a new window
  
  Scenario: Admin can't click on View Invoice if the invoice has not been generated
    Given I click on "Orders"
    And I press "View" for order "Bob Schmob"
    Then I should not see "View Invoice"

  Scenario: Admin tries to generate invoice for order without items
    Given "Bob Schmob"'s order contains no items
    And I click on "Orders"
    And I press "View" for order "Bob Schmob"
    And I press "Generate Invoice"
    Then I should see "The order contains no items. There's nothing to invoice..."



