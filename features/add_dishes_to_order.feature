@javascript
Feature: Allow end user to select dishes and quantities to order.
  As an end-user
  In order to start my order
  I would like to be able to select a quantity of each dish I would like to order.

  Background:
    Given the following dishes exist:
      | name    | description            | price | min_quantity | of_type |
      | Dish 1  | Description for Dish 1 | 100   | 10           | dish    |
      | Dish 2  | Description for Dish 2 | 200   | 20           | dish    |
      | Dish 3  | Description for Dish 3 | 300   | 1            | dish    |
      | Cutlery | Knife, fork and spoon  | 2     | 1            | cutlery |
    And there are no custom translations

  Scenario: User can manipulate quantity with + and - buttons
    When I go to the landing page
    And I click on + for "Dish 1"
    And I click on + for "Dish 2"
    And I click on + for "Dish 2"
    And I click on "Next"
    Then I should see "Dish 1"
    And I should see "1,000 SEK"
    And I should see "Dish 2"
    And I should see "4,200 SEK"
    And I should not see "Dish 3"