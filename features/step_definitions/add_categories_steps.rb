Given(/^the following categories exist:$/) do |table|
  table.hashes.each do |category|
    FactoryGirl.create(:category, category)
  end
end

When(/^I press "([^"]*)" for category "([^"]*)"$/) do |arg1, arg2|
  category = Category.find_by(name: category_name)
  within("#category") do
    click_link_or_button link
  end
end
