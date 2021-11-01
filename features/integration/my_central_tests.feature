Feature: My Central Tests Validation
# Data key needs to be added
  @delete_when_done @integration
  Scenario: My Central - Auto Policy Validation 1
    Given I login my central account using "valid_creds_my_central_1" fixture
    And I have loaded the fixture file named "my_central_validations_1"
    Then I validate contact agent details
    And I validate view my policy details
    And I validate billing and payments details
# Data key needs to be added
  @delete_when_done @integration
  Scenario: My Central - Auto Policy Validation 2
    Given I login my central account using "valid_creds_my_central_2" fixture
    And I have loaded the fixture file named "my_central_validations_2"
    Then I validate contact agent details
    And I validate view my policy details
    And I validate billing and payments details
# Data key needs to be added
  @delete_when_done @integration
  Scenario: My Central - Umbrella Policy Validation
    Given I login my central account using "valid_creds_my_central_3" fixture
    And I have loaded the fixture file named "my_central_validations_3"
    Then I validate contact agent details
    And I validate view my policy details for umbrella
    And I validate billing and payments details
# Data key needs to be added
  @delete_when_done @integration
  Scenario: My Central - Home Policy Validation
    Given I login my central account using "valid_creds_my_central_4" fixture
    And I have loaded the fixture file named "my_central_validations_4"
    Then I validate contact agent details
    And I validate view my policy details
    And I validate billing and payments details