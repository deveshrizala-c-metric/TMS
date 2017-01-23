Feature: IssueSummary

  Scenario: Viewing Index Page of IssueSummaries
    Given I am on the "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/issuesummaries"
    Then I should see the List of IssueSummary

  Scenario: Create IssueSummary
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/issuesummaries/new"
    And I create a New IssueSummary
    And I click on the "Create"
    Then I should redirect to "/issuesummaries"

  Scenario: View IssueSummary Show page
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/issuesummaries"
    And I should see the List of IssueSummary
    And I should see "Show" button
    And I press the "Show" button
    Then I should redirect to IssueSummary Show page

  Scenario: View IssueSummary Edit page
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/issuesummaries"
    And I should see the List of IssueSummary
    And I should see "Edit" button
    And I press the "Edit" button
    Then I should redirect to IssueSummary Edit page

  Scenario: Update IssueSummary
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/issuesummaries"
    And I should see the List of IssueSummary
    And I should see "Edit" button
    And I press the "Edit" button
    And I should redirect to IssueSummary Edit page
    And I updated IssueSummary
    Then I should redirect to IssueSummary Show page

  Scenario: Delete IssueSummary
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/departments"
    And I should see the List of IssueSummary
    And I should see "Delete" button
    And I press the "Delete" button
    And IssueSummary will be deleted
    Then I should redirect to "/issuesummaries/deleted"

    Scenario: Restore IssueSummary
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/issuesummaries"
    And I should see the List of IssueSummary
    And I should see "Delete" button
    And I press the "Delete" button
    And IssueSummary will be deleted
    And I visit "/issuesummaries/deleted"
    And I should see the List of Deleted IssueSummary
    And should see the "Restore" button
    And press the "Restore" button
    And IssueSummary will be restored
    Then I should redirect to the "/issuesummaries"