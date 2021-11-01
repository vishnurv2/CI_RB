@auto @account_management
Feature: Validation on Account summary page

  @fixture_auto_policy_none_combined_none_adjusted @delete_when_done @TestCaseKey=PAT-T33 @PAT-6665
  Scenario: Validating action dropdown from Account summary page
    Given I have created a new "Auto" policy
    Then I click on Actions button from top right corner of policy summary page
    And I validate the options under Actions dropdown
      | Options                         |
      | Add Note                        |
      | Log Activity                    |
      | Send Email                      |
      | Move Product to Another Account |
      | Delete Quote                    |
      | Save Quote                      |
    When I navigate to "Account Overview" using the left nav
    Then I click on Actions button from top right corner of policy summary page
    And I validate the options under Actions dropdown
      | Options                          |
      | New Quote                        |
      | Add Note                         |
      | Log Activity                     |
      | Send Email                       |
      | Flag for domestic abuse          |
      | Move Products to Another Account |

  @fixture_auto_policy_none_combined_none_adjusted @regression @delete_when_done @TestCaseKey=PAT-T3870 @PAT-6665
  Scenario: Validating action dropdown from Account summary page after fully issue policy
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then I click on Actions button from top right corner of policy summary page
    And I validate the options under Actions dropdown
      | Options                         |
      | New Quote                       |
      | Add Note                        |
      | Log Activity                    |
      | Send Email                      |
      | Report a Claim                  |
      | Flag for domestic abuse         |
      | Move Products to Another Account |
    And I navigate to policies "IN-Auto" using the left nav
    Then I click on Actions button from top right corner of policy summary page
    And I validate the options under Actions dropdown
      | Options                         |
      | Create Policy Change            |
      | View Policy Declaration         |
      | View ID Card                    |
      | View Edit Policy Distribution   |
      | Add Note                        |
      | Log Activity                    |
      | Send Email                      |
      | Reprint Policy Declaration      |
      | Cancel Non Renew                |
      | Move Product to Another Account |

  @TestCaseKey=PAT-T51 @PAT-6664 @regression
  Scenario: Validating the tabs present on Account Summary page
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    Then I validate all the tabs present in Account Summary page
      | tabs         |
      | Summary Tab  |
      | Activity Tab |
      | Notes Tab    |
      | Emails Tab   |
      | Calls Tab    |
      | Tasks Tab    |