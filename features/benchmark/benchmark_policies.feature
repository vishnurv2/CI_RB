@wip
Feature: Benchmark Policy Integration

  @fixture_valid_creds @benchmarks
  Scenario Outline: Insert IN-Auto Benchmark Policies into PAT for testing
    Given I login legacy account using "valid_creds" fixture
    Given I search for "Personal Automobile" using the following benchmark <benchmark> for "Indiana"
    Then I save and extract the benchmark to a file
    And I modify the data in the XML with <name>
    Then I post the data to rate accord and continue
    And I navigate to the newly created account
    #Then the premium should be the same as legacy

    Examples:
      | benchmark | name    |
      | 6013901   | INAUTO  |
      | 6013902   | INAUTO  |
      | 6013903   | INAUTO  |
      | 6013904   | INAUTO  |
      | 6013905   | INAUTO  |
      | 6013906   | INAUTO  |
      | 6013907   | INAUTO  |
      | 6013908   | INAUTO  |
      | 6013909   | INAUTO  |
      | 6013910   | INAUTO  |
      | 6013911   | INAUTO  |
      | 6013912   | INAUTO  |
      | 6013913   | INAUTO  |
      | 6013914   | INAUTO  |
      | 6013915   | INAUTO  |
      | 6013916   | INAUTO  |
      | 6013917   | INAUTO  |

  @fixture_valid_creds @benchmarks
  Scenario Outline: Insert IN-Home Benchmark Policies into PAT for testing
    Given I login legacy account using "valid_creds" fixture
    Given I search for "Homeowners" using the following benchmark <benchmark> for "Indiana"
    Then I save and extract the benchmark to a file
    And I modify the data in the XML with <name>
    Then I post the data to rate accord and continue
    And I navigate to the newly created account
    #Then the premium should be the same as legacy
    Examples:
      | benchmark | name    |
      | 5013900   | INHOME  |
      | 5013901   | INHOME  |
      | 5013902   | INHOME  |
      | 5013903   | INHOME  |
      | 5013904   | INHOME  |
      | 5013905   | INHOME  |
      | 5013906   | INHOME  |
      | 5013907   | INHOME  |
      | 5013908   | INHOME  |
      | 5013909   | INHOME  |
      | 5013910   | INHOME  |
      | 5013911   | INHOME  |
      | 5013912   | INHOME  |
      | 5013913   | INHOME  |
      | 5013914   | INHOME  |
      | 5013915   | INHOME  |
      | 5013916   | INHOME  |
      | 5013917   | INHOME  |
      | 5013918   | INHOME  |

  @fixture_valid_creds @benchmarks
  Scenario Outline: Insert IN-Dwelling Benchmark Policies into PAT for testing
    Given I login legacy account using "valid_creds" fixture
    Given I search for "Dwelling" using the following benchmark <benchmark> for "Indiana"
    Then I save and extract the benchmark to a file
    And I modify the data in the XML with <name>
    Then I post the data to rate accord and continue
    And I navigate to the newly created account
    #Then the premium should be the same as legacy
    Examples:
      | benchmark | name        |
      | 5513900   | INDWELLING  |
      | 5513901   | INDWELLING  |
      | 5513902   | INDWELLING  |
      | 5513903   | INDWELLING  |
      | 5513904   | INDWELLING  |
      | 5513905   | INDWELLING  |
      | 5513906   | INDWELLING  |
      | 5513907   | INDWELLING  |
      | 5513908   | INDWELLING  |
      | 5513909   | INDWELLING  |
      | 5513910   | INDWELLING  |
      | 5513911   | INDWELLING  |
      | 5513912   | INDWELLING  |
      | 5513913   | INDWELLING  |
      | 5513914   | INDWELLING  |
      | 5513915   | INDWELLING  |
      | 5513916   | INDWELLING  |
      | 5513917   | INDWELLING  |

  @fixture_valid_creds @benchmarks
  Scenario Outline: Insert IN-Dwelling Benchmark Policies into PAT for testing
    Given I login legacy account using "valid_creds" fixture
    Given I search for "Boatowners" using the following benchmark <benchmark> for "Indiana"
    Then I save and extract the benchmark to a file
    And I modify the data in the XML with <name>
    Then I post the data to rate accord and continue
    And I navigate to the newly created account
    #Then the premium should be the same as legacy
    Examples:
      | benchmark | name    |
      | 5813900   | INBOAT  |
      | 5813901   | INBOAT  |
      | 5813902   | INBOAT  |


  @fixture_valid_creds @benchmarks
  Scenario Outline: Insert IN-Umbrella Benchmark Policies into PAT for testing
    Given I login legacy account using "valid_creds" fixture
    Given I search for "Personal Umbrella" using the following benchmark <benchmark> for "Indiana"
    Then I save and extract the benchmark to a file
    And I modify the data in the XML with <name>
    Then I post the data to rate accord and continue
    And I navigate to the newly created account
    #Then the premium should be the same as legacy
    Examples:
      | benchmark | name    |
      | 5713900   | INPUP  |

