@auto @driver
Feature: Personal Auto driver modal

  @TestCaseKey=PAT-T106
  Scenario:  Auto Driver Modal Validations Appear
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add a blank driver
    Then I should see the following validations on the auto driver modal
      | validation                            |
      | First Name is required                |
      | Last Name is required                 |
      | Gender is required                    |
      | Date Of Birth is required             |
      | Marital Status is required            |
      | Relationship to Applicant is required |

#    Change in functionality as per story card PAT-8179
  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T103
  Scenario: Verify no drivers error message
    Given I have created a new "auto" policy
    And I remove the first driver
    Then I validate error message on drivers panel
#    Then The following reasons to remove a driver should appear in the list for the first driver
#      | reason                                          |
#      | Not in Household                                |
#      | In Household with Other Insurance               |
#      | Excluded Driver                                 |
#      | Deceased                                        |
#      | Learners Permit                                 |
#      | Disabled                                        |
#      | Not Licensed                                    |
#      | Duplicate Name                                  |
#      | Unknown to Applicant                            |
#      | Active Military                                 |
#      | On Another Central Auto Policy                  |
#      | Other                                           |

  @TestCaseKey=PAT-T105
  Scenario:  Drivers on a personal auto policy can be edited
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I edit the first driver
    Then The edited driver info should display in the driver grid on the auto summary page

  @delete_when_done @TestCaseKey=PAT-T104
  Scenario:  Multiple drivers can be added to an auto policy
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add 2 random drivers from the auto summary page
    Then the drivers should display in the driver grid on the auto summary page

  @delete_when_done @TestCaseKey=PAT-T21
  Scenario: Drivers on a personal auto policy can be removed
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add 1 random driver from the auto summary page
    When I remove the first driver for the following reason, "Excluded Driver"
    Then The deleted driver should not display in the driver grid

  @delete_when_done @TestCaseKey=PAT-T107
  Scenario: Driver Modal Accident and Violation Validations Appear
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I attempt to add a blank accident and a blank violation
    Then There should be 2 accidents and violations
    And All accident and violation validations should be visible
