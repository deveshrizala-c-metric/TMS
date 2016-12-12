Feature: User

Scenario: Viewing user's Sign in page
  Given I am on "/users/sign_in" page
  When I fill in the "Email" field with "aaa@example.com"
  And I fill in the "Password" field with "aaa@123#"
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

Scenario: Create New User
  Given I am on "/users/sign_up" page
  When I fill in the "Fullname" field with "aaa xyz"
  And I fill in the "Phone" field with "9988776655"
  And I fill in the "Email" field with "aaa@example.com"
  And I fill in the "Password" field with "aaa@123#"
  And I click on "Sign up"
  Then I should redirect to the "/users/sign_in"

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
