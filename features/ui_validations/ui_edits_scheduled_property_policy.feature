Feature: Validating the UI-Edits for Scheduled Property policy

  @fixture_ui_edits_agreed_SPP_miscellaneous @delete_when_done @scheduled_property @lambda
  Scenario: Verify validation with Miscellaneous Collections optional coverages selected
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    And I begin issuance
    Then I should see the following issue messages on alerts side bar
      #| The description for Miscellaneous Collections cannot be empty.|
      | Scheduled and Agreed amounts must equal what was quoted for MiscellaneousCollections.|

  @fixture_ui_edits_agreed_SPP_vehicle @delete_when_done @scheduled_property @lambda
  Scenario: Verify validation - Vehicle information has not been completed
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    And I begin issuance
    Then I should see the following issue messages on alerts side bar
      | Vehicle information has not been completed. |

  @fixture_ui_edits_agreed_SPP_trailer @delete_when_done @scheduled_property
  Scenario: Verify validation - Trailer information has not been completed
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    And I begin issuance
    Then I should see the following issue messages on alerts side bar
      | Trailer information has not been completed. |

  @fixture_ui_edits_agreed_SPP_all_vehicle @delete_when_done @scheduled_property
  Scenario: Verify validation - total amount of Vehicles
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    And I click on modify "scheduled property classes and items" information
    Then I click on Add Item to add another category
    And I populate data for "Trailer" category
    Then I click on Add Item to add another category
    And I populate data for "Equipment" category
    Then I save and close the "scheduled property classes" modal
    And I begin issuance
    Then I should see the following issue messages on alerts side bar
      |The total amount of Vehicles/Trailers/Equipment for GroundMaintenanceVehicles must equal what was quoted.|

  @fixture_schedule_property_classes_items_coins @delete_when_done @scheduled_property
  Scenario: Verify validation - Vault Location required
    Given I have started a new scheduled property policy through the "scheduled property policy level coverages" modal
    And I click on modify "scheduled property classes and items" information
    When I provide details for scheduled property policy optional coverages modal
    And I begin issuance
    Then I should see the following issue messages on alerts side bar
      | At least one party with Vault or Safety deposit box location role needed when Amount in a Vault or Safety deposit box. |







