Feature: Department

  Scenario: Viewing Department's Index Page
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/departments"
    Then I should see the List of Departments

  Scenario: Create Department
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/departments/new"
    And I create a New Department
    And I click on the "Create"
    Then I should redirect to "/departments"

  Scenario: View department Show page
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/departments"
    And I should see the List of Departments
    And I should see "Show" button
    And I press the "Show" button
    Then I should redirect to department Show page

  Scenario: View department Edit page
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/departments"
    And I should see the List of Departments
    And I should see "Edit" button
    And I press the "Edit" button
    Then I should redirect to department Edit page

  Scenario: Update department
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/departments"
    And I should see the List of Departments
    And I should see "Edit" button
    And I press the "Edit" button
    And I should redirect to department Edit page
    And I updated department
    Then I should redirect to department Show page

  Scenario: Delete department
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/departments"
    And I should see the List of Departments
    And I should see "Delete" button
    And I press the "Delete" button
    And Department will be deleted
    Then I should redirect to "/departments/deleted"

  Scenario: Restore department
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/departments"
    And I should see the List of Departments
    And I should see "Delete" button
    And I press the "Delete" button
    And Department will be deleted
    And I visit "/departments/deleted"
    And I should see the List of Deleted Departments
    And should see the "Restore" button
    And press the "Restore" button
    And Department will be restored
    Then I should redirect to the "/departments"

