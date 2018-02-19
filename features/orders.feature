Feature: List orders
  As Giga-Food
  In order to make a decision to start an order
  I like to have three options approve, cancel and a input filed with transport size

  Background:
    Given an admin exists with email "admin@example.com" and password "password"
    And I'm logged in as admin
    And I go to the dashboard
    And the following categories exist:
      | name     | description                  | sort_key |
      | Starters | Description for starters     | 1        |
      | Mains    | Description for dessertss... | 2        |
      | Desserts | Description for dessertss... | 3        |

    And the following dishes exist:
      | name                 | description                                                                                                                                                                                                                                                                                                                            | price | min_quantity | category |
      | Starter dish         | Really really long description for this dish explaining how awesome it tastes and looks. We need this multi line description to test what happends if the table is overlaping the footer.                                                                                                                                              | 100   | 10           | Starters |
      | Another Starter dish | Really really long description for this dish explaining how awesome it tastes and looks. We need this multi line description to test what happends if the table is overlaping the footer.                                                                                                                                              | 100   | 10           | Starters |
      | Dessert dish         | Our dessert dish is simply fucking awespme                                                                                                                                                                                                                                                                                             | 200   | 10           | Desserts |
      | Main dish            | Our main dish is simply fucking awesome. It would take a really really long description for this dish explaining how awesome it actually is                                                                                                                                                                                            | 200   | 10           | Mains    |
      | Another Main dish    | Our main dish is simply fucking awesome. It would take a really really long description for this dish explaining how awesome it actually is. Really really long description for this dish explaining how awesome it tastes and looks. We need this multi line description to test what happends if the table is overlaping the footer. | 200   | 10           | Mains    |

    And the following orders exist:
      | billing_name | delivery_date    | billing_email          |
      | Bob Schmob   | 2017-11-20 12:00 | bob.schmob@example.com |
      | John Smith   | 2017-10-10 12:00 | john.smith@example.com |
      | Kari Lee     | 2017-10-08 12:00 | kari.lee@example.com   |

    And "Bob Schmob"'s order contains:
      | dish_name            | quantity |
      | Starter dish         | 10       |
      | Another Starter dish | 10       |
      | Dessert dish         | 20       |
      | Main dish            | 20       |
      | Another Main dish    | 20       |


  Scenario: View a list of confirmed orders
    When I press "Orders"
    Then I should see "Bob Schmob"
    When I press "View" for order "Bob Schmob"
    Then I should see "Confirm Order"
    And I should see "Cancel Order"
    When I press "Confirm Order"
    Then I should see "Confirmed!"
    And I should not see "Cancel Order"

  Scenario: View a list of orders
    When I press "Orders"
    Then I should see "Bob Schmob"
    When I press "View" for order "Bob Schmob"
    Then I should see "Confirm Order"
    And I should see "Cancel Order"
    When I press "Cancel Order"
    Then I should see "Canceled!"
    And I should not see "Confirm Order"

  Scenario: Send order confirmation
    When I press "Orders"
    And I press "View" for order "Bob Schmob"
    And I press "Confirm Order"
    Then "bob.schmob@example.com" should receive an email
    And "bob.schmob@example.com" should see "Confirmation from Gigafood" in the subject
    And "bob.schmob@example.com" should see "Thanks for ordering from Gigafood!" in the email
    And "bob.schmob@example.com" should see "Your selected pickup" in the email
    And "bob.schmob@example.com" should see "hello@gigafood.se" in the email
    And "bob.schmob@example.com" should see "8 120 543 76" in the email
    And "bob.schmob@example.com" should see "Total: 0 kr" in the email
    And "bob.schmob@example.com" should see "VAT 12%: 0 kr" in the email
    And "bob.schmob@example.com" should see "Total price inc. VAT: 0 kr" in the email
    And "bob.schmob@example.com" should see "Allergies" in the email
    And "bob.schmob@example.com" should see "peanuts" in the email
    And "bob.schmob@example.com" should see "Delivery" in the email
    And "bob.schmob@example.com" should see "You have selected pick-up." in the email
    And "bob.schmob@example.com" should see "Payment" in the email
    And "bob.schmob@example.com" should see "Please specify your billing details. An invoice from Gigafood will be sent to you shortly after your delivery is fulfilled." in the email
    And "bob.schmob@example.com" should see "Bob Schmob" in the email
    And "bob.schmob@example.com" should see "Big corp 222" in the email
    And "bob.schmob@example.com" should see "19900101-1234" in the email
    And "bob.schmob@example.com" should see "Street 42" in the email
    And "bob.schmob@example.com" should see "123 45" in the email
    And "bob.schmob@example.com" should see "555 123 45 66" in the email
    And "bob.schmob@example.com" should see "bob.schmob@example.com" in the email
    And "bob.schmob@example.com" should see "Acceptance" in the email
    And "bob.schmob@example.com" should see "We recommend that you send your request five days ahead." in the email

  Scenario: Send order cancelation
    When I press "Orders"
    And I press "View" for order "Kari Lee"
    And I press "Cancel Order"
    Then "kari.lee@example.com" should receive an email
    And "kari.lee@example.com" should see "Cancelation from Gigafood" in the subject
    And "kari.lee@example.com" should see "Regretfully, your order has been canceled!" in the email
    