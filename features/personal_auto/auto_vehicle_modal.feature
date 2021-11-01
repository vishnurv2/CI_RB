@auto @vehicle @indiana_auto @personal_auto
Feature: Auto-Vehicle modal

  Background:
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I start adding another new vehicle to the auto policy
#    I start adding a new vehicle to an existing auto policy

  @TestCaseKey=PAT-T139
  Scenario: Year - make - model selection
    And I have loaded the fixture file named "auto_vehicle_modal_ymms_1"
    And I enter a vehicle year in the auto vehicle modal by ymm
    Then the vehicle make select list should contain options
    When I enter a vehicle make in the auto vehicle modal by ymm
    Then the vehicle model select list should contain options
    When I enter a vehicle model in the auto vehicle modal by ymm
    Then the vehicle style select list should contain options
    When I enter a vehicle style in the auto vehicle modal by ymm
    Then the vehicle identification number should be populated

  @TestCaseKey=PAT-T133
  Scenario: Year - make - model from VIN
    And I have loaded the fixture file named "auto_vehicle_modal_vin"
    When I enter a vehicle identification number in the auto vehicle modal
    Then the vehicle details should be returned

  @TestCaseKey=PAT-T135
  Scenario Outline: Vinmaster data updates performance - anti-theft - passive restraints - and high performance
    And I have loaded the fixture file named "a_3_1_c_1"
    When I enter the VIN <vin> in the auto vehicle modal
    Then I should see <performance> for performance in the auto vehicle modal
    And I should see <anti_theft> for anti theft device in the auto vehicle modal
    And I should see <restraint> for passive restraint device in the auto vehicle modal
    Examples:
      | vin        | performance  | anti_theft               | restraint                                                       |
      | 1GY&3AKJ&G | High         | Passive Disabling Device | Driver and Passenger Front, Side, Head and Rear Curtain Airbags |

  @TestCaseKey=PAT-T2087
  Scenario Outline: Vinmaster data updates performance Intermediate performance
    And I have loaded the fixture file named "a_3_1_c_1"
    When I enter the VIN <vin> in the auto vehicle modal
    Then I should see <performance> for performance in the auto vehicle modal
    And I should see <anti_theft> for anti theft device in the auto vehicle modal
    And I should see <restraint> for passive restraint device in the auto vehicle modal
    Examples:
      | vin        | performance  | anti_theft               | restraint                                                       |
      | 2HNYD2H2&A | Intermediate | Passive Disabling Device | Driver and Passenger Front, Side, Head and Rear Curtain Airbags |

  @TestCaseKey=PAT-T131
  Scenario Outline: Vehicle use triggers miles driven pleasure
    And I have loaded the fixture file named "auto_vehicle_modal_ymms_2"
    When I select <use_type> for vehicle use in the auto vehicle modal
    Then I <miles_driven> see the miles driven one way input in the auto vehicle modal
    And  I <days_per_week> see the driven days per week input in the auto vehicle modal
    Examples:
      | use_type                     | miles_driven | days_per_week |
      | Pleasure (0-2 Miles One Way) | should not   | should not    |

  @TestCaseKey=PAT-T136
  Scenario Outline: Vehicle use triggers miles driven farm
    And I have loaded the fixture file named "auto_vehicle_modal_ymms_2"
    When I select <use_type> for vehicle use in the auto vehicle modal
    Then I <miles_driven> see the miles driven one way input in the auto vehicle modal
    And  I <days_per_week> see the driven days per week input in the auto vehicle modal
    Examples:
      | use_type | miles_driven | days_per_week |
      | Farm     | should not   | should not    |

  @TestCaseKey=PAT-T134
  Scenario Outline: Vehicle use triggers miles driven work
    And I have loaded the fixture file named "auto_vehicle_modal_ymms_2"
    When I select <use_type> for vehicle use in the auto vehicle modal
    Then I <miles_driven> see the miles driven one way input in the auto vehicle modal
    And  I <days_per_week> see the driven days per week input in the auto vehicle modal
    Examples:
      | use_type                        | miles_driven | days_per_week |
      | Work - 15 Miles or More One Way | should not   | should not    |

  @TestCaseKey=PAT-T2088
  Scenario Outline: Vehicle use triggers miles driven work less than 15 miles
    And I have loaded the fixture file named "auto_vehicle_modal_ymms_2"
    When I select <use_type> for vehicle use in the auto vehicle modal
    Then I <miles_driven> see the miles driven one way input in the auto vehicle modal
    And  I <days_per_week> see the driven days per week input in the auto vehicle modal
    Examples:
      | use_type                          | miles_driven | days_per_week |
      | Work - Less Than 15 Miles One Way | should not   | should not    |

  @TestCaseKey=PAT-T132
  Scenario Outline: Vehicle use triggers miles driven business
    And I have loaded the fixture file named "auto_vehicle_modal_ymms_2"
    When I select <use_type> for vehicle use in the auto vehicle modal
    Then I <miles_driven> see the miles driven one way input in the auto vehicle modal
    And  I <days_per_week> see the driven days per week input in the auto vehicle modal
    Examples:
      | use_type | miles_driven | days_per_week |
      | Business | should not   | should not    |

  @TestCaseKey=PAT-T138
  Scenario: Invalid VIN generates an error
    And I have loaded the fixture file named "auto_vehicle_modal_invalid_vin"
    When I enter a vehicle identification number in the auto vehicle modal
    Then an invalid VIN error should be displayed

  @TestCaseKey=PAT-T140
  Scenario: Black book fields are required
    And I have loaded the fixture file named "a_3_1_c_6"
    When I select Yes for agreed value in the auto vehicle modal
    And I try to submit the auto vehicle modal without filling it out
    Then I should see an error message for the black book year field saying "Year is required."
    When I enter a black book year in the auto vehicle modal
    And I try to submit the auto vehicle modal without filling it out
    Then I should see an error message for the black book make field saying "Make is required."
    When I enter a black book make in the auto vehicle modal
    And I try to submit the auto vehicle modal without filling it out
    Then I should see an error message for the black book model field saying "Model is required."
    When I enter a black book model in the auto vehicle modal
    And I try to submit the auto vehicle modal without filling it out
    Then I should see an error message for the black book series field saying "Series is required."
    When I enter a black book series in the auto vehicle modal
    And I try to submit the auto vehicle modal without filling it out
    Then I should see an error message for the black book style field saying "Style is required."

#    bug PAT-10235
  @TestCaseKey=PAT-T137
  Scenario: Some vehicle types dont require a vehicle use
    And I have loaded the fixture file named "auto_vehicle_modal_ymms_3"
    When I select "Limited Use Auto" for the type of vehicle
    Then I should not see the "vehicle use" field in the auto vehicle modal
    #When I select "Limited Use Auto" for the type of vehicle
    #Then I should not see the "vehicle use" field in the auto vehicle modal
    #When I select "Antique" for the type of vehicle
    #Then I should not see the "vehicle use" field in the auto vehicle modal

  @TestCaseKey=PAT-T129
  Scenario: Setting vehicle fields causes black book agreed value fields to appear
    And I have loaded the fixture file named "auto_vehicle_modal_ymms_agreed_value_1"
    When I select Yes for agreed value in the auto vehicle modal
    Then the black book year field should be visible in the auto vehicle modal
    When I enter a vehicle year in the auto vehicle modal by ymm
    Then the black book year field should not be visible in the auto vehicle modal
    And the black book make field should be visible in the auto vehicle modal
    When I enter a vehicle make in the auto vehicle modal
    Then the black book make field should not be visible in the auto vehicle modal
    And the black book model field should be visible in the auto vehicle modal
    When I enter a vehicle model in the auto vehicle modal
    Then the black book model field should not be visible in the auto vehicle modal
    And the black book series field should be visible in the auto vehicle modal
    When I enter a black book series in the auto vehicle modal
    And the black book style field should be visible in the auto vehicle modal

  @TestCaseKey=PAT-T130
  Scenario: Setting vehicle fields causes non-black book agreed value fields to appear
    And I have loaded the fixture file named "auto_vehicle_modal_ymms_agreed_value_2"
    When I enter a vehicle identification number in the auto vehicle modal
    And I have entered the black book fields on the auto vehicle modal
    Then I should see options for the vehicle value displayed on the auto vehicle modal
    When I select Original Cost New for the vehicle value type on the auto vehicle modal
    Then the Original Cost New should have a currency
    When I select Current Retail Value for the vehicle value type on the auto vehicle modal
    Then the Current Retail Value should have a currency
