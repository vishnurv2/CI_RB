@auto @account_management
Feature: Autoplus policies can be created and updated

  @delete_when_done @TestCaseKey=PAT-T170
  Scenario Outline:  Create an auto policy Auto Plus assortment Combined
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
    | fixture_file                           |
    | aplc_autoplus_combined_none            |

  @delete_when_done @TestCaseKey=PAT-T168
  Scenario Outline:  Create an auto policy Auto Plus assortment Combined Uninsured
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                           |
      | aplc_autoplus_combined_uninsured       |

  @delete_when_done @TestCaseKey=PAT-T167
  Scenario Outline:  Create an auto policy Auto Plus assortment Split
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                           |
      | aplc_autoplus_split_none               |

  @delete_when_done @TestCaseKey=PAT-T169
  Scenario Outline:  Create an auto policy Auto Plus assortment Split Uninsured
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                           |
      | aplc_autoplus_split_uninsured          |

