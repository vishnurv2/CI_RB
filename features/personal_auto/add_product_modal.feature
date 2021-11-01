@auto @account_management @indiana_auto
Feature: Add Product Modal

  @TestCaseKey=PAT-T98
  Scenario: Add Product Modal Controls Appear
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I open the add product modal
    Then The "Add Product" modal should be visible
    And the new product controls should not be visible on the add product modal
    When I check automobile on the add product modal
    Then the new product controls should be visible on the add product modal

  @TestCaseKey=PAT-T5415 @regression @PAT-12307
  Scenario: WT - Add Products - Same Information Being Used
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I open the add product modal
    Then The "Add Product" modal should be visible
    When I select automobile on the add product modal
    And I select watercraft on the add product modal
    Then I validate hover over message on add product modal
