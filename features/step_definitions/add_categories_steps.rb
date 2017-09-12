Given(/^the following categories exist:$/) do |table|
  table.hashes.each do | category |
    Category.create(category)
  end
end

When(/^I press "([^"]*)" for "([^"]*)"$/) do |link, category|
  category = Category.find_by(name: name)
  within("#category_#{category.name}") do
    click_link_or_button link
  end
end
