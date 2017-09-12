Feature: As Gigafood,
  In order to see my order schedule,
  I need to see a calendar with upcoming orders and their information.

Background:
  Given an admin exists with email "admin@example.com" and password "password"
  And I'm loged in as admin user "admin@example.com"
  Given I go to the dashboard
  And the following orders exist:
   | name       | description | price | order_date       | delivery_date    |
   | Bob Schmob | Bobs order  | 100   | 2017-11-15 10:00 | 2017-11-20 12:00 |
   | John Smith | Johns order | 200   | 2017-10-05 11:00 | 2017-10-10 12:00 |
   | Kari Lee   | Karis order | 300   | 2017-10-03 14:00 | 2017-10-08 12:00 |

Scenario: I should be able to view my upcoming bookings on a calendar
  Then I should see "Google Calendar"
