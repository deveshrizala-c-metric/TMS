Given(/^I am on the "([^"]*)" page$/) do |path|
  visit path
end

Then(/^I should see the List of IssueSummary$/) do
  @issue_sums = IssueSummary.all

  page.should have_content(@issue_sums.name)
end

When(/^I create a New IssueSummary$/) do
  @issue_sum = FactoryGirl.create(:issue_summary)
end

Then(/^I should redirect to IssueSummary Show page$/) do
  visit issuesummary_path(@issue_sums.first)
end

Then(/^I should redirect to IssueSummary Edit page$/) do
  visit edit_issuesummary_path(@issue_sums.first)
end

When(/^I updated IssueSummary$/) do
  @issue_sums.first.update_attribute(:name, "Hardware")
end

When(/^IssueSummary will be deleted$/) do
  @issue_sums.first.delete
end

When(/^I should see the List of Deleted IssueSummary$/) do
  visit deleted_issuesummaries_path
end

When(/^IssueSummary will be restored$/) do
  IssueSummary.restore(@issue_sums.first)
end