#driver assignments modal and panel are removed as per card PAT- 9769
@known_issue @auto @driver
Feature: Personal auto driver assignment

  @fixture_a_4_8_a @delete_when_done @regression @TestCaseKey=PAT-T209
  Scenario: Primary use drivers can be assigned to each vehicle
    Given I have started a new auto policy through the "auto_driver" modal
    And I add 1 random drivers from the auto summary page
    When I assign a primary driver to each vehicle
    Then The driver assignments should be displayed in the summary

  @fixture_a_4_8_a @delete_when_done @regression @TestCaseKey=PAT-T208
  Scenario: Applicants are listed in the driver assignment dropdown
    Given I have started a new auto policy through the "auto_driver" modal
    When I open the driver assignment modal
    Then The applicants will be listed in the driver assignment modal

  @fixture_a_4_8_b @delete_when_done @TestCaseKey=PAT-T207
  Scenario: Trigger validation errors while editing a driver
    Given I have started a new auto policy through the "auto_driver" modal
    And I add 1 random drivers from the auto summary page
    When I add a blank driver assignment
    Then I should see the following errors on the page
      | Primary Driver is required.|

  @fixture_a_4_8_c @delete_when_done @regression @TestCaseKey=PAT-T210
  Scenario: Secondary use drivers can be assigned to each vehicle
    Given I have started a new auto policy through the "auto_driver" modal
    When I assign a primary and secondary driver to each vehicle
    Then The driver assignments should be displayed in the summary

  @fixture_a_4_8_c @delete_when_done @regression @TestCaseKey=PAT-T205
  Scenario: Drivers are removed from the vehicles occasional driver list when they are assigned
    Given I have started a new auto policy through the "auto_driver" modal
    And I open the driver assignment modal
    Then The drop downs for the primary and occasional use drivers should include all drivers
    When I assign a primary driver to each vehicle without saving
    Then The drop down for the occasional driver should not include the primary driver

  @fixture_a_4_8_c @delete_when_done @regression @TestCaseKey=PAT-T206
  Scenario: Driver assignments can be edited
    Given I have started a new auto policy through the "auto_driver" modal
    And I assign a primary and secondary driver to each vehicle
    When I edit the driver assignments, by swapping the primary and occasional use drivers
    Then The driver assignments should be displayed in the summary

  ##### Below is unverified
  ### 6/3/2020 determined this will be counted towards the completed count
  @regression @fixture_a_4_8_c @delete_when_done @wip
  Scenario: Deleting Occasional Use Driver Assignments Presents Validation Message
    Given I have started a new auto policy through the "auto_driver" modal
    When I modify the driver assignment
    Then I should see the driver assignment validation messages
