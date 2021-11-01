@wip
Feature: Create a new policy

  @fixture_auto_policy_autoplus_combined_none
  Scenario: Generate policies
    Given I have created 39 new "Auto" policies
    Then I can save the account IDs starting at number 1

  ###### Everything Below is not verified to work with Angular ##########

  @fixture_auto_policy_autoplus_combined_none
  Scenario Outline: Generate Quote Options Policy
    Given I have created a new "Auto" policy
    Then I can save my activity ID and account ID in the "<fixture_file>" file
  Examples:
    | fixture_file                              |
    | qo_existing_auto_autoplus_combined_none_1 |
    | qo_existing_auto_autoplus_combined_none_2 |
    | qo_existing_auto_autoplus_combined_none_3 |
    | qo_existing_auto_autoplus_combined_none_4 |

  @fixture_auto_policy_autoplus_combined_none
  Scenario: Generate Account Navbar Policy
    Given I have created a new "Auto" policy
    When I begin issuance
    Then I can save my activity ID and account ID in the "existing_account_navbar" file

  @fixture_auto_policy_autoplus_combined_none
  Scenario: Generate No Territory Codes Policy
    Given I have created a new "Auto" policy
    When I change the address to be invalid
    Then I can save my activity ID and account ID in the "existing_account_no_territory_codes" file

  @delete_when_done @fixture_manual_coverage_created_deleted
  Scenario: Generate Manual Policy Coverage Policy
    Given I have started a new auto policy through the "auto policy coverages" modal
    When I add a manual policy coverage
    #existing_account_manual_policy_coverages has been changed to contain more than just the IDs, this step will overwrite
    # Then I can save my activity ID and account ID in the "existing_account_manual_policy_coverages" file

  @delete_when_done @fixture_manual_coverage_created_deleted
  Scenario: Generate Manual Vehicle Coverage Policy
    Given I have started a new auto policy up to the "auto vehicle coverages" modal
    When I add a manual vehicle coverage
    Then I can save my activity ID and account ID in the "existing_account_manual_vehicle_coverages" file

  Scenario Outline: Create a auto policies for use in fixture
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    Then I can save my activity ID and account ID in a new fixture based on <fixture_file>
    Examples:
      | fixture_file                                  |
      | auto_policy_autoplus_combined_none            |
      | auto_policy_none_combined_none                |
      | auto_policy_none_combined_uninsured           |
      | auto_policy_sig_combined_uninsured            |
      | auto_policy_none_combined_none_young_driver   |
      | auto_policy_none_combined_none_new_driver     |
      | auto_policy_autoplus_combined_none_old_driver |

  Scenario Outline: Create a auto policies for use in fixture with begin issuance
    Given I have created a new "Auto" policy using the <new_account_file> fixture
    Then I can save my activity ID and account ID in the "<account_number_file>" file
    And I begin issuance
    Examples:
      | new_account_file                              | account_number_file                         |
      | auto_policy_none_combined_none                | existing_auto_none_combined_none_billing    |

  Scenario Outline: Create a auto policies for use in fixture
    Given I have created a new "Auto" policy using the <new_account_file> fixture
    Then I can save my activity ID and account ID in the "<account_number_file>" file
    Examples:
      | new_account_file                              | account_number_file                         |
      | auto_policy_autoplus_combined_uninsured       | existing_auto_autoplus_combined_uninsured_1 |
      | auto_policy_autoplus_combined_uninsured       | existing_auto_autoplus_combined_uninsured_2 |
      | auto_policy_summit_combined_uninsured         | existing_auto_summit_combined_uninsured_1   |
      | auto_policy_summit_combined_uninsured         | existing_auto_summit_combined_uninsured_2   |
      | auto_policy_none_combined_none                | existing_auto_none_combined_none_1          |
      | auto_policy_none_combined_none                | existing_auto_none_combined_none_2          |
      | auto_policy_none_combined_none                | existing_auto_none_combined_none_3          |
      | auto_policy_autoplus_split_none               | existing_auto_autoplus_split_none_1         |
      | auto_policy_autoplus_split_none               | existing_auto_autoplus_split_none_2         |
      | auto_policy_autoplus_split_uninsured          | existing_auto_autoplus_split_uninsured_1    |
      | auto_policy_autoplus_split_uninsured          | existing_auto_autoplus_split_uninsured_2    |
      | auto_policy_none_split_none                   | existing_auto_none_split_none_1             |
      | auto_policy_none_split_none                   | existing_auto_none_split_none_2             |
      | auto_policy_none_split_uninsured              | existing_auto_none_split_uninsured_1        |
      | auto_policy_none_split_uninsured              | existing_auto_none_split_uninsured_2        |
      | auto_policy_none_split_uninsured              | existing_auto_none_split_uninsured_3        |
      | auto_policy_none_split_uninsured              | existing_auto_none_split_uninsured_4        |
      | auto_policy_sig_combined_none                 | existing_auto_sig_combined_none_1           |
      | auto_policy_sig_combined_none                 | existing_auto_sig_combined_none_2           |
      | auto_policy_sig_split_none                    | existing_auto_sig_split_none_1              |
      | auto_policy_sig_split_none                    | existing_auto_sig_split_none_2              |
      | auto_policy_sig_split_uninsured               | existing_auto_sig_split_uninsured_1         |
      | auto_policy_sig_split_uninsured               | existing_auto_sig_split_uninsured_2         |
      | auto_policy_sig_split_uninsured               | existing_auto_sig_split_uninsured_3         |
      | auto_policy_summit_combined_none              | existing_auto_summit_combined_none_1        |
      | auto_policy_summit_combined_none              | existing_auto_summit_combined_none_2        |
      | auto_policy_summit_split_none                 | existing_auto_summit_split_none_1           |
      | auto_policy_summit_split_none                 | existing_auto_summit_split_none_2           |
      | auto_policy_summit_split_uninsured            | existing_auto_summit_split_uninsured_1      |
      | auto_policy_summit_split_uninsured            | existing_auto_summit_split_uninsured_2      |
      | auto_policy_sig_split_uninsured               | existing_auto_sig_split_uninsured_no_prem   |

  Scenario Outline: No issues to resolve accounts
    Given I have created a new "Auto" policy using the <new_account_file> fixture
    Then I can save my activity ID and account ID in the "<account_number_file>" file
    And I fully issue the policy
    Examples:
      | new_account_file                                       | account_number_file                           |
      | auto_policy_autoplus_combined_none_full_vin            | existing_auto_none_combined_none_1_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_2_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_3_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_4_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_5_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_6_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_7_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_8_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_9_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_split_none_1_issued        |
      #| auto_policy_none_split_none_adjusted                   | existing_auto_none_split_none_2_issued        |
      #| auto_policy_none_split_none_adjusted                   | existing_auto_none_split_none_3_issued        |

  @fixture_auto_policy_none_combined_none_adjusted @regression @wip
  Scenario Outline: No issues to resolve accounts
    Given I have created a new "Auto" policy using the <new_account_file> fixture
    Then I can save my activity ID and account ID in the "<account_number_file>" file
    And I begin issuance
    And I answer underwriting questions
    And I navigate to "Payment Options" using the left nav
    When I populate the billing using the "billing_modal_defaults" fixture file
    Then I update auto applicant using "auto_policy_none_combined_none_adjusted"
    And I order CLUE/MVR and save
    And I issue the policy
    Examples:
      | new_account_file                                       | account_number_file                           |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_1_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_2_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_3_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_4_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_5_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_6_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_7_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_8_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_combined_none_9_issued     |
      | auto_policy_none_combined_none_adjusted                | existing_auto_none_split_none_1_issued        |
      | auto_policy_none_split_none_adjusted                   | existing_auto_none_split_none_2_issued        |
      | auto_policy_none_split_none_adjusted                   | existing_auto_none_split_none_3_issued        |