@auto @party_validation
Feature: ability to add a party with the role of a Contact

  @fixture_auto_policy_party_applicant_only_required @PAT-7336 @TestCaseKey=PAT-T407 @delete_when_done @post_deploy_candidate @regression
  Scenario Outline: Validate Contact applicant first description and role applies
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Contact" and add new party details
    Then I should see <first contact description> under the Contact role
    And I validate "Contact" role details and both role applies options "save and close" the modal
  Examples:
    |first contact description|
    |A contact is an individual to whom you may communicate with regarding selected account and/or products via phone, email, or mail.|

  @fixture_auto_policy_party_applicant_only_required @PAT-7336 @TestCaseKey=PAT-T607 @regression @delete_when_done
  Scenario Outline: Validate Contact applicant second description and role applies - account level and products
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Contact" and add new party details
    Then I should see <second contact description> under the Contact role in next line
    And I validate "Contact" role details and both role applies options "save and close" the modal
    Examples:
      |second contact description|
      |Example: Adult child managing elderly parent's financial matters.|

  @fixture_auto_policy_party_applicant_only_required @PAT-7336 @TestCaseKey=PAT-T590 @regression @delete_when_done
  Scenario: Validate Contact applicant description and role applies - only products
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Contact" and add new party details
    Then I select only Products from role applies to
    When I validate "Contact" role details and "save and close" the modal

  @fixture_auto_policy_party_applicant_only_required @PAT-7336 @TestCaseKey=PAT-T591 @regression @delete_when_done
  Scenario: Validate Contact applicant description and role applies - only account level
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Contact" and add new party details
    Then I select only Account level from role applies to
    When I validate "Contact" role details and "save and close" the modal

  @fixture_auto_policy_party_applicant_only_required @PAT-7336 @TestCaseKey=PAT-T591 @regression @delete_when_done
  Scenario: Validate Save and add another party functionality
    Given I have created a new "Auto" policy
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Individual" and role as "Contact" and add new party details
    Then I validate "Contact" role details and "save and add another party" the modal
    And I select party type as "Individual" and role as "Contact" and add new party details after navigating from Thank you modal

   @fixture_auto_policy_party_applicant_one_required_left @PAT-7336 @TestCaseKey=PAT-T593 @regression @delete_when_done
  Scenario: Validate Warning when required field left unfilled
     Given I have created a new "Auto" policy
     Then I navigate to "Account Overview" using the left nav
     And I select party type as "Individual" and role as "Contact" and add new party details only one required left
     Then I validate "Contact" role details and try to click "save and close ignore validation" and "First Name is required." warning appears

