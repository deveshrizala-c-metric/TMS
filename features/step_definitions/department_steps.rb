Given(/^I am on a "([^"]*)"$/) do |path|
  visit path
end

Then(/^I should see the List of Departments$/) do
  @departments = Department.all

  page.should have_content(@departments.name)
end

When(/^I create a New Department$/) do
  @department = FactoryGirl.create(:department)
end

When(/^I click on the "([^"]*)"$/) do |element|
  click_on element
end

Then(/^I should redirect to "([^"]*)"$/) do |path|
  visit path
end

Then(/^I should redirect to department Show page$/) do
  visit department_path(@departments.first)
end

Then(/^I should redirect to department Edit page$/) do
  visit edit_department_path(@departments.first)
end

When(/^I updated department$/) do
  @departments.first.update_attribute(:name, "Management")
end

When(/^I should see the List of Deleted Departments$/) do
  visit deleted_departments_path
end

When(/^Department will be deleted$/) do
  @departments.first.delete
end

When(/^Department will be restored$/) do
  Department.restore(@departments.first)
end