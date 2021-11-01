@auto
Feature: Summit Auto policies can be created

  @delete_when_done @TestCaseKey=PAT-T180
  Scenario Outline:  Create an auto policy Summit assortment combined
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                    |
      | aplc_summit_combined_none       |

  @delete_when_done @TestCaseKey=PAT-T183
  Scenario Outline:  Create an auto policy Summit assortment combined Uninsured
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                    |
      | aplc_summit_combined_uninsured  |

  @delete_when_done @TestCaseKey=PAT-T182
  Scenario Outline:  Create an auto policy Summit assortment split
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                 |
      | aplc_summit_split_none       |

  @delete_when_done @TestCaseKey=PAT-T181
  Scenario Outline:  Create an auto policy Summit assortment split Uninsured
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                 |
      | aplc_summit_split_uninsured  |
