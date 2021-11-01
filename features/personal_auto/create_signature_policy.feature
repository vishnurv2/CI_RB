@auto
Feature: Signature Auto policies can be created

  @delete_when_done @TestCaseKey=PAT-T179
  Scenario Outline:  Create an auto policy Signature assortment
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                           |
      | aplc_sig_combined_none                 |

  @delete_when_done @TestCaseKey=PAT-T178
  Scenario Outline:  Create an auto policy Signature assortment Uninsured
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                           |
      | aplc_sig_combined_uninsured            |

  @delete_when_done @TestCaseKey=PAT-T176
  Scenario Outline:  Create an auto policy Signature assortment split
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                           |
      | aplc_sig_split_none                    |

  @delete_when_done @TestCaseKey=PAT-T177
  Scenario Outline:  Create an auto policy Signature assortment split Uninsured
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Then I should be on the auto summary
    When I update the coverages using the <fixture_file> fixture
    Then the coverages I entered display in the auto coverages panel
    Examples:
      | fixture_file                           |
      | aplc_sig_split_uninsured               |
