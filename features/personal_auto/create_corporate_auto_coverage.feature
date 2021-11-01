Feature: Corporate auto coverage

  @delete_when_done @TestCaseKey=PAT-T175 @auto
  Scenario Outline:  Create an auto policy Signature assortment
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I update the coverages using the <fixture_file> fixture
    And I add the policy level optional coverage "Corporate Auto Coverage"
    And I refresh the page
    Then the "Corporate Auto Coverage" should be applied
    Examples:
      | fixture_file                           |
      | aplc_none_combined_none                |
