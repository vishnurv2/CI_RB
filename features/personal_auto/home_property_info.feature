@homeowners @account_management
Feature: Home - Property Information screen

  @fixture_home_policy_none_combined_none @delete_when_done @TestCaseKey=PAT-T288 @PAT-6848
  Scenario:  Home - Property Information modal
    Given I have started a new home policy up to the "property info" modal
    And I select form type as "3 - Special"
    Then I verify the following options of premise use
      | premise_use               |
      | Primary                   |
      | Secondary                 |
      | Seasonal                  |
      | Vacant                    |
      | Occasionally Occupied     |
    And I provide details and save and close property information modal using "property_info_seasonal" fixture
    When I click on modify property information modal
    Then I verify the details present on property information modal
    And I select form type as "4 - Tenants"
    Then I verify the following options of premise use
      | premise_use               |
      | Primary                   |
      | Secondary                 |
      | Seasonal                  |
      | Vacant                    |
      | Occasionally Occupied     |
    And I select form type as "5 - Comprehensive"
    Then I verify the following options of premise use
      | premise_use               |
      | Primary                   |
      | Secondary                 |
      | Seasonal                  |
      | Vacant                    |
      | Occasionally Occupied     |
    And I select form type as "6 - Condominium"
    Then I verify the following options of premise use
      | premise_use               |
      | Primary                   |
      | Secondary                 |
      | Seasonal                  |
      | Vacant                    |
      | Occasionally Occupied     |
      | Rented to Others (Condo)  |
    And I provide details and save and close property information modal using "property_info_condominium" fixture
    When I click on modify property information modal
    Then I verify the details present on property information modal
    And I select form type as "6(C) - Summit Condo Owners"
    Then I verify the following options of premise use
      | premise_use               |
      | Primary                   |
      | Secondary                 |
      | Seasonal                  |
      | Vacant                    |
      | Occasionally Occupied     |
      | Rented to Others (Condo)  |