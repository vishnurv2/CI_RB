@auto @billing
Feature: Billing account modal

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T147
  Scenario: Add billing information to account - No Products Checked validation
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    Then I navigate till billing modal and validate it

  @fixture_auto_policy_autoplus_combined_none_full_vin @regression @TestCaseKey=PAT-T3690
  Scenario: Add billing information to account - No Products Checked validation
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    Then I navigate till billing modal and validate it
    When I populate the form without selecting a product
    Then I should see a validation message

  @delete_when_done @fixture_auto_policy_none_combined_none_full_vin @TestCaseKey=PAT-T149
  Scenario Outline: Add billing information to account
    Given I have created a new "auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    Then I navigate till billing modal and validate it
    When I populate the billing modal using the <fixture_file>
    Then the billing account should be listed in the Billing Account grid
    Examples:
      | fixture_file            |
      | billing_modal_new_payor |

  @delete_when_done @fixture_auto_policy_none_combined_none_full_vin @regression @TestCaseKey=PAT-T146 @ci
  Scenario Outline: Add billing information to account defaults
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    Then I navigate till billing modal and validate it
    When I populate the billing modal using the <fixture_file>
    Then the billing account should be listed in the Billing Account grid
    Examples:
      | fixture_file           |
      | billing_modal_defaults |

  @delete_when_done @fixture_auto_policy_none_combined_none_full_vin @regression @TestCaseKey=PAT-T145
  Scenario Outline: Add billing information to account new email
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    Then I navigate till billing modal and validate it
    When I populate the billing modal using the <fixture_file>
    Then the billing account should be listed in the Billing Account grid
    Examples:
      | fixture_file            |
      | billing_modal_new_email |

  @delete_when_done @fixture_auto_policy_none_combined_none_full_vin @regression @TestCaseKey=PAT-T148
  Scenario Outline: Add billing information to account new address
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    Then I navigate till billing modal and validate it
    When I populate the billing modal using the <fixture_file>
    Then the billing account should be listed in the Billing Account grid
    Examples:
      | fixture_file              |
      | billing_modal_new_address |
