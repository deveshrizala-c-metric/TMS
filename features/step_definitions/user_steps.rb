Given(/^I am on "([^"]*)" page$/) do |path|
  visit path
end


When(/^I fill in the "([^"]*)" field with "([^"]*)"$/) do |element,text|
  fill_in element, with: text
end

When(/^I click on "([^"]*)"$/) do |element|
  click_on element
end

Then(/^I should redirect to "([^"]*)" of application$/) do |path|
  visit path
end

When(/^I should see "([^"]*)" in a link$/) do |text|
  page.should have_link text
end

When(/^I click on the "([^"]*)" link$/) do |text|
  page.should have_link text
end

Then(/^I should redirect to the "([^"]*)"$/) do |path|
  visit path
end