@auto @policy_change
Feature: Policy Change Transportation Network Coverage

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @PAT-6890 @TestCaseKey=PAT-T260 @post_deploy_candidate @regression
  Scenario Outline: TNC - vehicle is rated with Transportation Network Coverage and is driven 20 or more hours per week
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then the product status should be "Issued"
    Then I add a policy change and specify the effective date
    When I provide details of transportation network coverage in auto vehicle coverage modal from tnc_more_than_20_hrs fixture
    Then I navigate to policies "Open Policy Changes" using the left nav
    And I should see <referral message> on underwriting referrals modal
    Examples:
      |referral message|
      |Vehicle's driven 20 hours or more per week rated with Transportation Network Coverage require underwriter approval prior to binding. This risk does not fit Central's target market.|

  @delete_when_done @fixture_auto_policy_driver_less_than_25_yrs @regression @PAT-6890 @TestCaseKey=PAT-T261
  Scenario Outline: TNC - vehicle is rated with Transportation Network Coverage and driver is less than 25 years old
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then the product status should be "Issued"
    Then I add a policy change and specify the effective date
    When I provide details of transportation network coverage in auto vehicle coverage modal from auto_policy_autoplus_tnc fixture
    Then I navigate to policies "Open Policy Changes" using the left nav
    And I should see <referral message> on underwriting referrals modal
    Examples:
      |referral message|
      |Underwriter approval is required prior to binding a driver age 21-24 with Transportation Network Coverage|

  @delete_when_done @fixture_auto_policy_driver_less_than_21_yrs @regression @PAT-6890 @TestCaseKey=PAT-T259
  Scenario Outline: TNC - vehicle is rated with Transportation Network Coverage and driver is less than 21 years old
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then the product status should be "Issued"
    Then I add a policy change and specify the effective date
    When I provide details of transportation network coverage in auto vehicle coverage modal from auto_policy_autoplus_tnc fixture
    Then I navigate to policies "Open Policy Changes" using the left nav
    And I should see <referral message> on underwriting referrals modal
    Examples:
      |referral message|
      |Underwriter approval is required prior to binding a driver less than 21 years old with Transportation Network Coverage.This risk does not fit Central's target market.|