@account_management @auto
Feature: Existing Account Modal

  Background:
    Given I have logged in
    And I log new personal account
    When I enter an agency name
    And I add first applicant using the first_applicant_details fixture
    And I save and close new personal account modal
    And I close the "add product" modal
    And I log new personal account
    And I enter agency name from cache
    And I add first applicant using applicant data cache
    And I save and continue on the new_personal_account modal

  @delete_when_done @fixture_b_1_1 @TestCaseKey=PAT-T213
  Scenario: Existing account modal - select existing account
    Then I select existing account
    Then I save and continue on the existing client modal
    And I refresh the page

  @delete_when_done @fixture_b_1_1 @TestCaseKey=PAT-T214
  Scenario: Existing account modal - Select new account
    Then I select new account
    Then I save and continue on the existing client modal
    And I refresh the page

