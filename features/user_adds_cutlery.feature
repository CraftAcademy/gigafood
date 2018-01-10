Feature: User wants cutlery
  As a user
  In order to have the option to buy cutlery
  I need to be able to add cutlery to my order.

  Background:
    Given the following categories exist:
      | name    | description                |
      | Starter | Description for category 1 |
      | Main    | Description for category 2 |
      | Dessert | Description for category 3 |

    And the following dishes exist:
      | name   | description            | price | min_quantity |
      | Dish 1 | Description for Dish 1 | 100   | 10           |
      | Dish 2 | Description for Dish 2 | 200   | 10           |
      | Dish 3 | Description for Dish 3 | 300   | 10           |

  Scenario: User adds cutlery
    Given I go to the landing page
    And I click on + for "Dish 1"
    Then I click on "Next"
    And I select "cutlery" and fill in quantity with "5"
    And I fill in all relevant fields and submit the order
