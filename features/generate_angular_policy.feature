@no_browser @wip
Feature: Create a new policy for Angular UI

  Background:
    Given I have requested the account from my fixture file
    And I have requested a token using the credentials from the authorization_server_api file

  Scenario: Generate policies for Angular - NO drivers
    When I insert 39 new angular new account with data in the api_add_account fixture
    Then I can save an angular account ID starting at number 1

  Scenario: Generate Policies and Save IDs With Valid Creds
    When I insert 12 new angular new account with data in the api_add_account fixture
    Then I can save the angular account IDs with valid creds starting at number 1

  #Scenario Outline: Create issued auto policies for use in fixture
  #  Given I have created a new "Auto" policy using the <new_account_file> fixture
  #  Then I can save my activity ID and account ID in the "<account_number_file>" file
  #  Then I begin issuance
  #  And I issue the policy
  #  Examples:
  #    | new_account_file                              | account_number_file                           |
  #    | auto_policy_none_combined_none                | existing_auto_none_combined_none_1_issued     |
  #    | auto_policy_none_combined_none                | existing_auto_none_combined_none_2_issued     |
  #    | auto_policy_none_combined_none                | existing_auto_none_combined_none_3_issued     |
  #    | auto_policy_none_combined_none                | existing_auto_none_combined_none_4_issued     |
  #    | auto_policy_none_combined_none                | existing_auto_none_combined_none_5_issued     |
  #    | auto_policy_none_split_none                   | existing_auto_none_split_none_1_issued        |
  #    | auto_policy_none_split_none                   | existing_auto_none_split_none_2_issued        |

  Scenario: Generate Policy and Save IDs With Valid Creds and Expected Applicant
    When I create an auto policy with applicant data under the expected_applicant key in the expected_applicant fixture
    Then I can save the angular account and policy IDs to the existing_account_with_applicant file with the additional data
    | <%= include_yml("valid_creds.yml") %>        |
    | <%= include_yml("expected_applicant.yml") %> |

  Scenario Outline: Generate Policy With Existing Applicants to Be Modified
    When I insert 3 new angular new account with data in the api_add_account fixture
    Then I can save the angular account and policy IDs to the <file> file with the additional data
    | <%= include_yml("valid_creds.yml") %> |
    Examples:
      | file                                             |
      | existing_account_with_applicant_to_be_modified   |
      | existing_account_with_applicant_to_be_modified_2 |

  # This wont work because the background above!!!
  #Scenario Outline: No issues to resolve accounts
  #  Given I have created a new "Auto" policy using the <new_account_file> fixture
  #  Then I can save my activity ID and account ID in the "<account_number_file>" file
  #  And I fully issue the policy
  #  Examples:
  #    | new_account_file                                       | account_number_file                           |
  #    | auto_policy_autoplus_combined_none_full_vin            | existing_auto_none_combined_none_1_issued     |
      
  Scenario: Generate Manual Policy Coverage Policy
    When I insert 1 new angular new account with data in the api_add_account fixture
    # Given I have started a new auto policy through the "auto policy coverages" modal
    # When I add a manual policy optional coverage
    #existing_account_manual_policy_coverages has been changed to contain more than just the IDs, this step will overwrite
    Then I can save the angular account and policy IDs to the existing_account_manual_policy_coverages file with the additional data
      | <%= include_yml("agent_creds.yml") %>     |
      | <%= include_yml("manual_coverage.yml") %> |
    # Then I can save my activity ID and account ID in the "existing_account_manual_policy_coverages" file
