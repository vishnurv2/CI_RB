Feature: Existing Applicant

  # 5/15 NOT completed yet
  ### 6/3/2020 determined this will be counted towards the completed count
  @regression @delete_when_done @fixture_manual_loss_invalid_date @wip @TestCaseKey=PAT-T3706
  Scenario: Auto General Info Validation Messages Appear
    Given I have started a new auto policy up to the "auto general info" modal
    Then Populating the auto general info modal with the specified data should generate a validation
     | file                                                       | validation                                 |
     | auto_general_info_modal_validation_effective_date_nov_2017 | Effective Date must be 11/1/2017 or later. |
     | auto_general_info_modal_validation_effective_date_exists   | Effective Date is required.                |
     | auto_general_info_modal_validation_risk_state              | Rating State is required.                  |
