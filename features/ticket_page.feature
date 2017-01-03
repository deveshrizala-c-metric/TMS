Feature: Ticket

  Scenario: Viewing Ticket's Index Page
    Given I am on the "/tickets"
    Then I should see the List of Tickets

  Scenario: View ticket show page
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/tickets"
    And I should see "Show" button
    And I press the "Show" button
    Then I should redirect to ticket Show page

  Scenario: Delete ticket from index page
    Given I am on "/users/sign_in" page
    And I log in with created user
    And I click on "Log in"
    And I should redirect to "/home" of application
    And I visit "/tickets"
    And I should see "Delete" button
    And I press the "Delete" button
    And Ticket will be deleted
    Then I should see the List of Tickets