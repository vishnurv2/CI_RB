@wip
Feature: Create a new policies for Post Deploy and Regression

  ## This is latest file I know that I need based on Angular accounts
  ## Will Generate fixture files based on environments

  @fixture_auto_policy_autoplus_combined_none
  Scenario: Generate policies
    Given I have created 39 new "Auto" policies
    Then I can save the account IDs starting at number 1

  @fixture_auto_policy_autoplus_combined_none_oh
  Scenario: Generate policies
    Given I have created 1 new "Auto" policies
    Then I can save the account IDs starting at number 19

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