@scheduled_property @coverage_validation
Feature: Scheduled Property - optional coverages classes and items

  @fixture_schedule_property_classes_items_null @delete_when_done @regression @TestCaseKey=PAT-T3304
  Scenario:  Policy issuance Scheduled Property - validating all classes
    Given I have created a new "scheduled_property" policy
    And I open the schedule property policy classes panel
    Then I should see the "Scheduled Property Classes" modal
    Then I should see the schedule property classes coverage
      | coverage                                                                           |
      | Bicycles                                                                           |
      | Cameras non professional                                                           |
      | Coins                                                                              |
      | Electronic Equipment Cellular Phones Other Media includes personal computers       |
      | Fine Arts With Breakage                                                            |
      | Fine Arts Without Breakage                                                         |
      | Firearms                                                                           |
      | Furs                                                                               |
      | Golfers Equipment                                                                  |
      | Ground Maintenance Vehicles                                                        |
      | Hearing Aids                                                                       |
      | Jewelry                                                                            |
      | Miscellaneous Collections                                                          |
      | Motorized Vehicles for Handicapped Persons                                         |
      | Musical Instruments non professional                                               |
      | Silverware                                                                         |
      | Sporting Equipment                                                                 |
      | Stamps                                                                             |
      | Wine Collection                                                                    |

  @fixture_scheduled_property_classes_items_bicycle @regression @delete_when_done @TestCaseKey=PAT-T3305
  Scenario: Scheduled Property policy with bicycle optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "BICYCLES" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_camera @regression @delete_when_done @TestCaseKey=PAT-T3306
  Scenario: Scheduled Property policy with camera(non professional) optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "CAMERAS (NON PROFESSIONAL)" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_electronics @regression @delete_when_done @TestCaseKey=PAT-T3307
  Scenario: Scheduled Property policy with ELECTRONIC EQUIPMENT optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "ELECTRONIC EQUIPMENT, CELLULAR PHONES & OTHER MEDIA (INCLUDES PERSONAL COMPUTERS)" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_fine_arts @regression @delete_when_done @TestCaseKey=PAT-T3308
  Scenario: Scheduled Property policy with FINE ARTS WITH BREAKAGE optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "FINE ARTS WITH BREAKAGE" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_fine_arts_without_brokerage @regression @delete_when_done @TestCaseKey=PAT-T3309
  Scenario: Scheduled Property policy with FINE ARTS WITHOUT BREAKAGE optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "FINE ARTS WITHOUT BREAKAGE" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_firearms @regression @delete_when_done @TestCaseKey=PAT-T3310
  Scenario: Scheduled Property policy with FIREARMS optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "FIREARMS" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_furs @regression @delete_when_done @TestCaseKey=PAT-T3311
  Scenario: Scheduled Property policy with Furs optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "FURS" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_golfers_equipment @regression @delete_when_done @TestCaseKey=PAT-T3312
  Scenario: Scheduled Property policy with GOLFERS EQUIPMENT optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "GOLFERS EQUIPMENT" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_ground_maintenance @regression @delete_when_done @TestCaseKey=PAT-T3313
  Scenario: Scheduled Property policy with Ground Maintenance Vehicles optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "GROUND MAINTENANCE VEHICLES" present on scheduled property classes and items coverages panel with diff heading

  @fixture_schedule_property_motorized_vehicle_for_handicapped_persons @regression @delete_when_done @TestCaseKey=PAT-T3793
  Scenario: Scheduled Property policy with MOTORIZED VEHICLES FOR HANDICAPPED PERSONS optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "MOTORIZED VEHICLES FOR HANDICAPPED PERSONS" present on scheduled property classes and items coverages panel with diff heading

  @fixture_schedule_property_classes_items_hearing_aids @regression @delete_when_done @TestCaseKey=PAT-T3314
  Scenario: Scheduled Property policy with Hearing Aids optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "HEARING AIDS" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_jewelry @regression @delete_when_done @TestCaseKey=PAT-T3315
  Scenario: Scheduled Property policy with Jewelry optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "JEWELRY" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_miscellaneous @regression @delete_when_done @TestCaseKey=PAT-T3316
  Scenario: Scheduled Property policy with Miscellaneous Collections optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "MISCELLANEOUS COLLECTIONS" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_musical_instruments_non_professional @regression @delete_when_done @TestCaseKey=PAT-T3317
  Scenario: Scheduled Property policy with Musical Instruments non professional optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "MUSICAL INSTRUMENTS (NON PROFESSIONAL)" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_silverware @regression @delete_when_done @TestCaseKey=PAT-T3318
  Scenario: Scheduled Property policy with SILVERWARE optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "SILVERWARE" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_sporting_equipment @regression @delete_when_done @TestCaseKey=PAT-T3319
  Scenario: Scheduled Property policy with Sporting Equipment optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "SPORTING EQUIPMENT" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_stamps @regression @delete_when_done @TestCaseKey=PAT-T3320
  Scenario: Scheduled Property policy with Stamps optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "STAMPS" present on scheduled property classes and items coverages panel

  @fixture_schedule_property_classes_items_wine_collection @regression @delete_when_done @TestCaseKey=PAT-T3321
  Scenario: Scheduled Property policy with WINE COLLECTION optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    Then I validate "WINE COLLECTION" present on scheduled property classes and items coverages panel
