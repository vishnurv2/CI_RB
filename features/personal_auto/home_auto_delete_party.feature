@auto @party_validation @new_business
Feature: Ability to delete a role from an existing party

    #bug - PAT- 11438
  @fixture_auto_policy_party_loss_payee @delete_when_done @regression @TestCaseKey=PAT-T652 @PAT-7462 @known_issue
  Scenario:Delete one party or cancel on account summary page
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "c_1_5"
    And I add another applicant from the account summary page
    When I try to delete the applicant I added
    Then I should see a prompt asking me if I'm sure I want to remove the applicant
    When I answer no to the remove applicant prompt
    Then the applicant should remain in the list
    When I answer yes to the remove applicant prompt
    Then the applicant should be removed

  @fixture_auto_policy_party_loss_payee @delete_when_done @regression @TestCaseKey=PAT-T470 @PAT-7462
  Scenario:Add another role and delete the party on account summary page
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I begin issuance
    Then I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I add another role "Trust"
    Then I delete and validate the deleted party from applicant modal

    #bug - PAT- 11438
  @fixture_auto_policy_party_loss_payee @delete_when_done @regression @PAT-7462 @TestCaseKey=PAT-T3630 @known_issue
  Scenario:Goto HO screen and delete one party or cancel
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I begin issuance
    And I navigate to my quote "IN-Homeowners" using the left nav
    And I have loaded the fixture file named "c_1_5"
    And I add another applicant from the auto summary page
#    And I save and close the "add applicant" modal
    When I try to delete the applicant I added
    Then I should see a prompt asking me if I'm sure I want to remove the applicant
    When I answer no to the remove applicant prompt
    Then the applicant should remain in the list
    When I answer yes to the remove applicant prompt
    Then the applicant should be removed

    #bug - PAT- 11438
  @fixture_auto_policy_party_loss_payee @delete_when_done @regression @TestCaseKey=PAT-T566 @PAT-7462 @known_issue
  Scenario: Goto Auto screen and delete one party or cancel
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I begin issuance
    And I navigate to my quote "IN-Auto" using the left nav
    And I have loaded the fixture file named "c_1_5"
    And I add another applicant from the auto summary page
    #And I save and close the "add applicant" modal
    When I try to delete the applicant I added
    Then I should see a prompt asking me if I'm sure I want to remove the applicant
    When I answer no to the remove applicant prompt
    Then the applicant should remain in the list
    When I answer yes to the remove applicant prompt
    Then the applicant should be removed


  @fixture_auto_policy_party_loss_payee @delete_when_done @regression @TestCaseKey=PAT-T567 @PAT-7462
  Scenario:Add another role and delete the party on Auto summary page
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I begin issuance
    And I navigate to my quote "IN-Auto" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I add another role "Trust"
    Then I delete and validate the deleted party from applicant modal


  @fixture_auto_policy_party_loss_payee @delete_when_done @regression @TestCaseKey=PAT-T568 @PAT-7462
  Scenario:Add another role and delete the party on Homeowners summary page
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I begin issuance
    And I navigate to my quote "IN-Homeowners" using the left nav
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I add another role "Trust"
    Then I delete and validate the deleted party from applicant modal
