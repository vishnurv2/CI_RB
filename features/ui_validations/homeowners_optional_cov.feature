Feature: Validating the UI-Edits for homeowners policy

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Actual Cash Value Loss Settlement
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Actual Cash Value Loss Settlement |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Actual Cash Value Loss Settlement
      | Coverage A to Replacement Cost Percentage is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Assisted Living Care
    Given I have started a new home policy up to the "auto policy optional coverages" modal
#    When I have populated the auto policy optional coverages modal
    When I select the below Home Policy Level Optional Coverages
      | Assisted Living Care |
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Assisted Living Care
      | Total Personal Property Limit must be at least $10,000 |
      | Total Personal Property Limit is required              |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners @lambda
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Business Property - Increased Limit
    Given I have started a new home policy up to the "auto policy optional coverages" modal
#    When I have populated the auto policy optional coverages modal
    When I select the below Home Policy Level Optional Coverages
      | Business Property - Increased Limit |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Business Property - Increased Limit
      | The selected value is already included. Please select a different value or de-select the coverage |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Business Pursuits
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Business Pursuits |
#    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Business Pursuits
      | Name of Business is required |
      | Type of Business is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Canine - Exclusion Endorsement
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Canine Exclusion Endorsement |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Canine - Exclusion Endorsement
      | Name of Dog is required  |
      | Breed of Dog is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Coverage C - Increased Limits of Liability - Firearms
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Coverage C - Increased Limits of Liability - Firearms |
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Coverage C - Increased Limits of Liability - Firearms
      | Total Limit must be at least the included limit of $2,500                                         |
      | The selected value is already included. Please select a different value or de-select the coverage |
      | Total Limit is required                                                                           |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Coverage C - Increased Limits of Liability - Jewelry, Watches & Furs
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Coverage C - Increased Limits of Liability - Jewelry, Watches & Furs |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Coverage C - Increased Limits of Liability - Jewelry, Watches & Furs
      | The selected value is already included. Please select a different value or de-select the coverage |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Coverage C - Increased Limits of Liability - Money
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Coverage C - Increased Limits of Liability - Money |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Coverage C - Increased Limits of Liability - Money
      | The selected value is already included. Please select a different value or de-select the coverage |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Coverage C - Increased Limits of Liability - Portable Electronic Equipment in or upon a Motor Vehicle
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Coverage C - Increased Limits of Liability - Portable Electronic Equipment in or upon a Motor Vehicle |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Coverage C - Increased Limits of Liability - Portable Electronic Equipment in or upon a Motor Vehicle
      | The selected value is already included. Please select a different value or de-select the coverage |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Coverage C - Increased Limits of Liability - Securities
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Coverage C - Increased Limits of Liability - Securities |
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Coverage C - Increased Limits of Liability - Securities
      | Total Limit must be at least the included limit of $1,500                                         |
      | The selected value is already included. Please select a different value or de-select the coverage |
      | Total Limit is required                                                                           |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Coverage C - Increased Limits of Liability - Silverware, Goldware & Pewterware
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Coverage C - Increased Limits of Liability - Silverware, Goldware & Pewterware |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Coverage C - Increased Limits of Liability - Silverware, Goldware & Pewterware
      | The selected value is already included. Please select a different value or de-select the coverage |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Credit Card / Forgery
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Credit Card / Forgery |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Credit Card / Forgery
      | The selected value is already included. Please select a different value or de-select the coverage |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Earthquake
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Earthquake |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Earthquake
      | Deductible is required              |
      | Masonry Veneer Coverage is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Earthquake Loss Assessment
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Earthquake Loss Assessment |
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Earthquake Loss Assessment
      | Total Limit is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Home Business Plus
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Home Business Plus |
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Home Business Plus
      | Business Classification is required                               |
      | Number of Visitors Per Week is required                           |
      | Annual Gross Receipts is required                                 |
      | Accounts Receivable must be at least $10,000                      |
      | Accounts Receivable is required                                   |
      | Business Personal Property - On Premises must be at least $5,000  |
      | Business Personal Property - On Premises is required              |
      | Business Personal Property - Off Premises must be at least $5,000 |
      | Business Personal Property - Off Premises is required             |
      | Electronic Data Processing Coverage Limit must be at least $5,000 |
      | Electronic Data Processing Coverage Limit is required             |
      | Cellular Phone must be at least 500                               |
      | Cellular Phone is required                                        |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Incidental Farming Liability
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Incidental Farming Liability |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Incidental Farming Liability
      | Location is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Inland Flood
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Inland Flood |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Inland Flood
      | Has the insured had any flood claims in the last five years? is required |
      | Limit is required                                                        |
      | Deductible is required                                                   |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Landlord's Furnishings Coverage
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Landlord's Furnishings Coverage |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Landlord's Furnishings Coverage
      | The selected value is already included. Please select a different value or de-select the coverage |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Liability Extension - Occupied by Insured
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Liability Extension - Occupied by Insured |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Liability Extension - Occupied by Insured
      | Number of Families is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Liability Extension - Rented to Others
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Liability Extension - Rented to Others |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Liability Extension - Rented to Others
      | Number of Families is required |


#  Limited Fungi Wet or Dry Rot or Bacteria Coverage
#      |At least one field must have something other than the included limit selected. If you do not wish to increase your limits above the included amount, please de-select the coverage.|

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Loss Assessment - Additional Locations
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Loss Assessment - Additional Locations |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Loss Assessment - Additional Locations
      | Total Limit is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Loss Assessment - Residence Premises
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Loss Assessment - Residence Premises |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Loss Assessment - Residence Premises
      | The selected value is already included. Please select a different value or de-select the coverage |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Manual Coverage
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Manual Coverage |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Manual Coverage
      | Premium is required                 |
      | Description of Coverage is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Motorized Golf Cart - Physical Loss Coverage
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Motorized Golf Cart - Physical Loss Coverage |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Motorized Golf Cart - Physical Loss Coverage
      | Limit is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Ordinance or Law - Increased Limit
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Ordinance or Law - Increased Limit |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Ordinance or Law - Increased Limit
      | The selected value is already included. Please select a different value or de-select the coverage |

#  Other Members of Insured's Household Coverage
#      | Total Number of Other Members of Household is required                                            |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Other Structures - Rented to Others - Residence Premise
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Other Structures - Rented to Others - Residence Premise |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Other Structures - Rented to Others - Residence Premise
      | Total Limit for Rented Structure is required |
      | Number of Families is required               |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Other Structures - Specifically Insured - Off Premise
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Other Structures - Specifically Insured - Off Premise |
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Other Structures - Specifically Insured - Off Premise
      | Total Limit must be at least the included limit of $500                                           |
      | The selected value is already included. Please select a different value or de-select the coverage |
      | Total Limit is required                                                                           |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Other Structures - Specifically Insured - On Premise
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Other Structures - Specifically Insured - On Premise |
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Other Structures - Specifically Insured - On Premise
      | Total Limit must be at least the included limit of $500                                           |
      | The selected value is already included. Please select a different value or de-select the coverage |
      | Total Limit is required                                                                           |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Permitted Incidental Occupancies
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Permitted Incidental Occupancies |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Permitted Incidental Occupancies
      | Location is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Personal Cyber Protection
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Personal Cyber Protection |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Personal Cyber Protection
      | Amount is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Personal Injury
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Personal Injury |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Personal Injury
      | Field is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Personal Property Located in a Self-Storage Facility-Increased Limit
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Personal Property Located in a Self-Storage Facility-Increased Limit |
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Personal Property Located in a Self-Storage Facility-Increased Limit
      | Total Limit must be at least the included limit of $1,000                                         |
      | The selected value is already included. Please select a different value or de-select the coverage |
      | Total Limit is required                                                                           |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Personal Property-Increased Limit-Other Residences
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Personal Property-Increased Limit-Other Residences |
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Personal Property-Increased Limit-Other Residences
      | Total Limit must be at least the included limit of $1,000                                         |
      | The selected value is already included. Please select a different value or de-select the coverage |
      | Total Limit is required                                                                           |

#  Replacement Cost Loss Settlement of Certain Non-Building Structures

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Residence Employees -Additional Rate for More Than Two Employees
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Residence Employees -Additional Rate for More Than Two Employees |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Residence Employees -Additional Rate for More Than Two Employees
      | Total Number of Employees is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Snowmobile Coverage
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Snowmobile Coverage |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Snowmobile Coverage
      | Coverage Limit is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Special Loss Settlement
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Special Loss Settlement |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Special Loss Settlement
      | Total Percentage of Replacement Cost for Special Loss Settlement is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Theft of Building Materials
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Theft of Building Materials |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Theft of Building Materials
      | Total Limit must be at least $1,000 |
      | Total Limit is required             |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Theft of Personal Property Dwelling Under Construction
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Theft of Personal Property Dwelling Under Construction |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Theft of Personal Property Dwelling Under Construction
      | Limit is required           |
      | Inception Date is required  |
      | Expiration Date is required |

  @fixture_ui_edits_home_owner_optional_coverages_quotes @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Theft of Tools Optional Deductible
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I select the below Home Policy Level Optional Coverages
      | Theft of Tools Optional Deductible |
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Theft of Tools Optional Deductible
      | Total Limit must be at least 1000 |
      | Total Limit is required           |

  @fixture_ui_edit_ho_summit_tenant_form_type @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Option Coverage - Summit Tenant form type
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I have populated the auto policy optional coverages modal
    And I clear all the currency input fields
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Additions and Alterations - Increased Limit
      | The selected value is already included. Please select a different value or de-select the coverage |
#  Additions and Alterations - Other Residence
      | Total Limit is required                                                                           |

  @fixture_ui_edits_home_special_loss_settlement @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Verify Type and Number of employees working fields validation errors
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    And I select 'Owned & Operated by Insured' type for optional coverage 'Farming Personal Liability - Away From Premises'
    And I select 'In Residence' location for optional coverage 'Permitted Incidental Occupancies'
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
      | Number of employees working 40 days or less is required  |
      | Number of employees working 41 - 180 days is required    |
      | Number of employees working 181 days or more is required |
      | Total Number of Acres is required                        |
      | Type is required                                         |

  @fixture_ui_edits_home_owner_terre_haute_address @delete_when_done @homeowners
  Scenario: UI Edit: Homeowners Policy Optional Coverage - Verify Replacement Cost on the Home-Additional Amount validation errors
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I have populated the auto policy optional coverages modal
    And I save and continue on the Auto Policy Optional Coverages modal
    Then I should see the following errors on the page
#  Replacement Cost on the Home-Additional Amount
      | Total Percentage of Coverage A for Replacement Cost Loss Settlement is required |

# Validation step of UI edits are pending
  @fixture_homeowner_policy_optional_coverages @delete_when_done @homeowners @known_issue
  Scenario:  UI Edit: Homeowners Policy Optional coverage - Issuance
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    When I have populated the auto policy optional coverages modal
    And I save and close the "auto policy optional coverages" modal
    And I begin issuance
    And I navigate to my quote "IN - Homeowners" using the left nav
    And I open the optional policy coverage modal again
#    Then I should see the following errors on the page
#      | Total Personal Property Limit must be at least $10,000                                            |
#      | Total Personal Property Limit is required                                                         |
    And I close the "auto policy optional coverages" modal
    Then I should see the following issue messages on alerts side bar
      | Description of Business is required for Business Pursuits under the coverage Business Pursuits.                                                                                    |
      | Address is required for Earthquake Loss Assessment under the coverage Earthquake Loss Assessment.                                                                                  |
      | Year is required for Motorized Golf Cart - Physical Loss Coverage under the coverage Motorized Golf Cart - Physical Loss Coverage.                                                 |
      | Make is required for Motorized Golf Cart - Physical Loss Coverage under the coverage Motorized Golf Cart - Physical Loss Coverage.                                                 |
      | Model is required for Motorized Golf Cart - Physical Loss Coverage under the coverage Motorized Golf Cart - Physical Loss Coverage.                                                |
      | Identification Number is required for Motorized Golf Cart - Physical Loss Coverage under the coverage Motorized Golf Cart - Physical Loss Coverage.                                |
      | Address of Rented Unit is required for Landlord's Furnishings Coverage under the coverage Landlord's Furnishings Coverage.                                                         |
      | Address is required for Loss Assessment - Additional Locations under the coverage Loss Assessment - Additional Locations.                                                          |
      | Description of Conveyance is required for Incidental Low Power Recreational Vehicle under the coverage Incidental Low Power Recreational Vehicle.                                  |
      | Description of Structure is required for Other Structures Exclusion Endorsement under the coverage Other Structures Exclusion Endorsement.                                         |
      | Address is required for Other Structures - Not Specifically Insured - Off Premise under the coverage Other Structures - Not Specifically Insured - Off Premise.                    |
      | Address of Property is required for Personal Property-Increased Limit-Other Residences under the coverage Personal Property-Increased Limit-Other Residences.                      |
      | Year / Make / Model is required for Snowmobile Coverage under the coverage Snowmobile Coverage.                                                                                    |
      | Make is required for Snowmobile Coverage under the coverage Snowmobile Coverage.                                                                                                   |
      | Model is required for Snowmobile Coverage under the coverage Snowmobile Coverage.                                                                                                  |
      | Identification Number is required for Snowmobile Coverage under the coverage Snowmobile Coverage.                                                                                  |
      | Description of Specified Structure is required for Other Structures - Specifically Insured - On Premise under the coverage Other Structures - Specifically Insured - On Premise.   |
      | Address is required for Other Structures - Specifically Insured - Off Premise under the coverage Other Structures - Specifically Insured - Off Premise.                            |
      | Description of Specified Structure is required for Other Structures - Specifically Insured - Off Premise under the coverage Other Structures - Specifically Insured - Off Premise. |