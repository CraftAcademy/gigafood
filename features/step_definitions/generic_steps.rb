Then(/^show me the page$/) do
  save_and_open_page
end

When(/^I confirm popup$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^I click on "([^"]*)"$/) do |link_or_button|
  click_link_or_button link_or_button
end