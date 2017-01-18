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
  @user.add_role :admin
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

Then(/^I should see the list of Users$/) do
  @users = User.all
end

When(/^should see the "([^"]*)" button$/) do |text|
  page.should have_text text
end

When(/^press the "([^"]*)" button$/) do |text|
  page.should have_link text
end

Then(/^I should redirect to the user's "([^"]*)" page$/) do |path|
  visit users_path(@user)
end

When(/^User will be deleted$/) do
  visit users_path(@user.delete)
end

Then(/^I should see the list of Deleted Users$/) do
  @users = User.only_deleted
end

When(/^I create a New User and Delete a User$/) do
  @user = FactoryGirl.create(:user_with_ticket)
  @user.confirm
  @user.delete
end

When(/^User will be restored$/) do
  User.restore(@user.id, :recursive => true)
end