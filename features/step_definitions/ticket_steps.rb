
Given(/^I am on the "([^"]*)"$/) do |path|
  visit path
end

Then(/^I should see the List of Tickets$/) do
  @tickets = Ticket.all

  page.should have_content(@tickets.name)
end

When(/^I visit "([^"]*)"$/) do |path|
  visit path
end

When(/^I should see "([^"]*)" button$/) do |text|
  page.should have_text text
end

When(/^I press the "([^"]*)" button$/) do |text|
  page.should have_link text
end

Then(/^I should redirect to ticket Show page$/) do
  visit tickets_path(@user.tickets.first)
end

When(/^Ticket will be deleted$/) do
  visit tickets_path(@user.tickets.first.delete)
end

Then(/^I should see the list of Deleted Tickets$/) do
  @tickets = Ticket.only_deleted.where('user_id = ?',@user)
end

When(/^Ticket will be restored$/) do
  Ticket.restore(@user.tickets.first)
end