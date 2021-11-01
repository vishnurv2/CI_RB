@auto @driver
@indiana_auto @personal_auto @auto_prefill
Feature: Auto Prefill - Delete a Prefill Driver Not Added

  @fixture_auto_policy_autoplus_combined_none_clue_prefill @delete_when_done @TestCaseKey=PAT-T521 @regression @PAT-8194
  Scenario: Validating hover over message on prefilled driver not added
    Given I have started a new auto policy up to the "auto prefill" modal
#    When I uncheck the first prefill driver
    And I save and close the "auto prefill" modal
    Then I validate the delete button should be disabled for Prefill Driver not added
    And I validate the hover over message on delete button "Unable to delete the last applicant on the account or any policy"

  @fixture_auto_policy_autoplus_combined_none_clue_prefill_edit_party @delete_when_done @TestCaseKey=PAT-T661 @regression @PAT-8194
    Scenario: Validating adding role with edit and delete added role
    Given I have started a new auto policy up to the "auto prefill" modal
#    When I uncheck the first prefill driver
    And I save and close the "auto prefill" modal
    Then I navigate to "Account Overview" using the left nav
#    And I click on the edit party button and add edit party details
#    Then I add another role "Applicant" and "save and close" the modal
#    And I click on delete party button and verify the red bar
#    Then I click on delete button from red bar
    And I validate the delete button should be disabled for Prefill Driver not added on Account Overview

    #    Now Prefill driver does not appear in Prefill modal
  @fixture_auto_policy_autoplus_combined_none_clue_prefill_edit_party @delete_when_done @TestCaseKey=PAT-T662 @regression @PAT-8194 @known_issue
  Scenario: Validating adding role with edit and cancel deleting added role
    Given I have started a new auto policy up to the "auto prefill" modal
    When I uncheck the first prefill driver
    And I save and close the "auto prefill" modal
    Then I navigate to "Account Overview" using the left nav
    And I click on the edit party button and add edit party details
    Then I add another role "Applicant" and "save and close" the modal
    And I click on delete party button and verify the red bar
    Then I click on cancel button from red bar
    And I validate the roles "Applicant, Prefill Driver Not Added" are present

#    Now Prefill driver does not appear in Prefill modal
  @fixture_auto_policy_autoplus_combined_none_clue_prefill_edit_party @delete_when_done @TestCaseKey=PAT-T663 @regression @PAT-8194 @known_issue
  Scenario: Auto Summary page - Validating adding role with edit and delete added role
    Given I have started a new auto policy up to the "auto prefill" modal
    When I uncheck the first prefill driver
    And I save and close the "auto prefill" modal
    And I click on the edit party button and add edit party details
    Then I add another role "Applicant" and "save and close" the modal
    And I click on delete party button and verify the red bar
    Then I click on delete button from red bar
    And I validate the delete button should be disabled for Prefill Driver not added on Account Overview

#    Now Prefill driver does not appear in Prefill modal
  @fixture_auto_policy_autoplus_combined_none_clue_prefill_edit_party @delete_when_done @TestCaseKey=PAT-T664 @regression @PAT-8194 @known_issue
  Scenario: Auto summary page - Validating adding role with edit and cancel deleting added role
    Given I have started a new auto policy up to the "auto prefill" modal
    When I uncheck the first prefill driver
    And I save and close the "auto prefill" modal
    And I click on the edit party button and add edit party details
    Then I add another role "Applicant" and "save and close" the modal
    And I click on delete party button and verify the red bar
    Then I click on cancel button from red bar
    And I validate the roles "Applicant, Prefill Driver Not Added" are present