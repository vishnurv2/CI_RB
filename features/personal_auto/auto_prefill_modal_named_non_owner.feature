@auto @driver @indiana_auto @personal_auto @auto_prefill
Feature: Auto Prefill - Named non owner

#  bug PAT-8331
  @fixture_auto_policy_named_non_owner_clue_prefill @delete_when_done @PAT-7359 @regression @TestCaseKey=PAT-T37 @known_issue
  Scenario Outline: Validate message on Auto prefill modal and issues to resolve page for Named non owner - named individual and more than 1 driver
    Given I have started a new auto policy up to the "auto prefill" modal
    Then I validate message tailored to NNO followed by save and continue button
    When I provide drivers details followed by save and continue button
    And I navigate to account summary page through premium modal
    Then I should see <issue message> on issues to resolve page
    Examples:
      |issue message|
      |Only one driver applies when Named Non Owned with Named Individual coverage is selected.|

  #  bug PAT-8331
  @fixture_named_non_owner_individual_and_relative_auto_prefill @delete_when_done @PAT-7359 @regression @TestCaseKey=PAT-T289 @known_issue
  Scenario: Validate message on Auto prefill modal and issues to resolve page for Named non owner - individual and relative and more than 1 driver
    Given I have started a new auto policy up to the "auto prefill" modal
    Then I validate vehicles message tailored to NNO followed by save and continue button
    When I provide drivers details followed by save and continue button
    And I navigate to account summary page through premium modal
    Then I should not see any issues on issues to resolve page

  # PAT-8331
  @fixture_named_non_owner_individual_auto_prefill @delete_when_done @PAT-7359 @regression @TestCaseKey=PAT-T290 @known_issue
  Scenario: Validate message on Auto prefill modal and issues to resolve page for Named non owner - individual and 1 driver
    Given I have started a new auto policy up to the "auto prefill" modal
    Then I validate message tailored to NNO followed by save and continue button
    When I provide drivers details followed by save and continue button
    And I navigate to account summary page through premium modal
    Then I should not see any issues on issues to resolve page