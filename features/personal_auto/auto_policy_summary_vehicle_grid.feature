@auto @vehicle
Feature: Vehicle Grid functionality

    @delete_when_done @TestCaseKey=PAT-T122 @post_deploy_candidate @regression
    Scenario Outline: Quoting a policy generates a class code for vehicles Non-Regression Antique
      Given I have created a new "Auto" policy using the <fixture_file> fixture
        And my vehicles should not have a class code in the vehicle grid
      Examples:
        | fixture_file                                             |
        | auto_policy_none_combined_none_antique_stated_value      |


    @delete_when_done @regression @TestCaseKey=PAT-T124
    Scenario Outline: Quoting a policy generates a class code for vehicles Non-Regression Classic
      Given I have created a new "Auto" policy using the <fixture_file> fixture
      And my vehicles should not have a class code in the vehicle grid
      Examples:
        | fixture_file                                             |
        | auto_policy_none_combined_none_classic                   |

    @delete_when_done @regression @TestCaseKey=PAT-T123 @PAT-9749
    Scenario Outline: Quoting a policy generates a class code for vehicles Non-Regression Prefill
      Given I have created a new "Auto" policy using the <fixture_file> fixture
      And my vehicles should not have a class code in the vehicle grid
      Examples:
        | fixture_file                                             |
        | auto_policy_autoplus_combined_none_clue_prefill          |


