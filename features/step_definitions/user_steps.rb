Given(/^I am on "([^"]*)" page$/) do |path|
  visit path
end

When(/^I create a New User$/) do
  @user = FactoryGirl.create(:user_with_ticket)
  @user.confirm
end

When(/^I click on "([^"]*)"$/) do |element|
  click_on element
end

Then(/^I should redirect to the "([^"]*)"$/) do |path|
  visit path
end

When(/^I log in with created user$/) do
  @user = FactoryGirl.create(:user_with_ticket)
  @user.confirm
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
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

# When(/^I log in with created user$/) do
#   @user = FactoryGirl.create(:user_with_ticket)
#   fill_in "Email", with: @user.email
#   fill_in "Password", with: @user.password
#   @user.confirm
# end

# # to be deleted
# When(/^I should redirect to a "([^"]*)"$/) do |path|
#   visit path
# end