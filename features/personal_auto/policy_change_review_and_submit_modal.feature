@policy_change
Feature:  Policy change - Review and submit modal

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @TestCaseKey=PAT-T632 @PAT-8425 @auto
  Scenario: Review and submit modal validation after policy change without discount
    Given I have created a new "Auto" policy
    And I fully issue the policy
    When I navigate to policies "In-Auto" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first vehicle from the auto policy summary page with the file "2010_honda_accord_partial_vin_non_agreed"
    When I navigate to policies "Open Policy Changes" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to policies "Open Policy Changes" using the left nav
    And I start issue policy change
    Then I validate Review and Submit Policy Change Modal

   #This is in process, on hold due to timeouts in begin issuance
  @fixture_home_policy_none_combined_none_pdf_validation @delete_when_done @regression @PAT-8425 @wip @TestCaseKey=PAT-T3560 @homeowners
  Scenario: Review and submit modal validation after policy change with discount
    Given I have created a new "home" policy
    And I fully issue the home policy with annual billing payment
    When I navigate to policies "In-Homeowners" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    Then I add a policy change with "Specify Date"
    When I edit the first property from the home policy summary page with the file "policy_change_property_info_modal"
    When I navigate to policies "Open Policy Changes" using the left nav
    And I start issue policy change
    Then I validate Review and Submit Policy Change Modal



