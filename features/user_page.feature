Feature: User

Scenario: Create New User
  Given I am on "/users/sign_up" page
  When I create a New User
  And I click on "Sign up"
  Then I should redirect to the "/users/sign_in"

Scenario: Viewing user's Sign in page
  Given I am on "/users/sign_in" page
  When I log in with created user
  And I click on "Log in"
  Then I should redirect to "/home" of application

Scenario: Link for Sign up page
  Given I am on "/users/sign_in" page
  When I should see "Sign up" in a link
  And I click on the "Sign up" link
  Then I should redirect to the "/users/sign_up"

Scenario: Link for Forgot Password page
  Given I am on "/users/sign_in" page
  When I should see "Forgot your password?" in a link
  And I click on the "Forgot your password?" link
  Then I should redirect to the "/users/password/new"

Scenario: Link for Receive Confirmation
  Given I am on "/users/sign_in" page
  When I should see "Didn't receive confirmation instructions?" in a link
  And I click on the "Didn't receive confirmation instructions?" link
  Then I should redirect to the "/users/confirmation/new"

Scenario: Link for Log in
  Given I am on "/users/sign_up" page
  When I should see "Log in" in a link
  And I click on the "Log in" link
  Then I should redirect to the "/users/sign_in"

Scenario: Link for Receive Confirmation
  Given I am on "/users/sign_up" page
  When I should see "Didn't receive confirmation instructions?" in a link
  And I click on the "Didn't receive confirmation instructions?" link
  Then I should redirect to the "/users/confirmation/new"

Scenario: Link for List of Users
  Given I am on "/users" page
  Then I should see the list of Users

Scenario: See the Show Button
  Given I am on "/users/sign_in" page
  When I log in with created user
  And I click on "Log in"
  And I should redirect to "/home" of application
  And I create a New User
  And I visit "/users"
  And should see the "Show" button
  And press the "Show" button
  Then I should redirect to the user's "Show" page

Scenario: See the Delete Button
  Given I am on "/users/sign_in" page
  When I log in with created user
  And I click on "Log in"
  And I should redirect to "/home" of application
  And I visit "/users"
  And should see the "Delete" button
  And press the "Delete" button
  And User will be deleted
  Then I should redirect to the "/users"

Scenario: List of Deleted Users
  Given I am on "/users/deleted" page
  Then I should see the list of Deleted Users

Scenario: See the Restore Button
  Given I am on "/users/sign_in" page
  When I log in with created user
  And I click on "Log in"
  And I create a New User and Delete a Userp
  And I should redirect to "/home" of application
  And I visit "/users/deleted"
  And should see the "Restore" button
  And press the "Restore" button
  And User will be restored
  Then I should redirect to the "/users"