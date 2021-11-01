@auto @billing
@epic_1852
Feature: Edit Billing account modal

   #Everything below needs re-worked as Billing is not longer accessible via navbar

    @delete_when_done @fixture_auto_policy_none_combined_none @regression @TestCaseKey=PAT-T153 @known_issue
    Scenario Outline: Add billing information to account and edit
      Given I have created a new "Auto" policy
      And I begin issuance
      And I navigate to "Billing & Payment Options" using the left nav
      When I populate the billing modal using the <fixture_file>
      Then the billing account should be listed in the Billing Account grid
      When I edit the billing modal with the new data in the <fixture_file>
      Then the billing account should be listed in the Billing Account grid
      Examples:
      | fixture_file                             |
      | billing_modal_new_email_edit_info        |