Feature: As gigafood, create, destroy and update categories
  As GigaFood
  In order to group the categoryes in different categories
  We need to add CRUD-functionality for categories

  Background:
    Given an admin exists with email "admin@example.com" and password "password"
    And I'm loged in as admin user "admin@example.com"
    Given I go to the dashboard
    And the following categories exist:
      | category_name  | description                 |
      | Starter        | Description for category 1  |
      | Main           | Description for category 2  |
      | Dessert        | Description for category 3  |

  Scenario: Add a new Category
    When I press "Category"
    And I press "New Category"
    And I fill in "Name" with "category 4"
    And I fill in "Description" with "Description for category 4"
    And I press "Create Category"
    Then I should see "Category was successfully created."

  Scenario: Update Category
    When I press "Category"
    And I press "Edit" for category "Starter"
    And I fill in "Description" with "Description for Starter"
    And I press "Update category"
    Then I should see "Category was successfully updated."

  Scenario: Delete category
    When I press "Category"
    And I press "Delete" for category "category 4"
    Then I should see "category was successfully destroyed."