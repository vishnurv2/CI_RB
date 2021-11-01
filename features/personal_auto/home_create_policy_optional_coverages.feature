@homeowners @account_management
Feature: Home policies can be created

  @fixture_home_policy_none_combined_none_loss_settlement_roof @delete_when_done @TestCaseKey=PAT-T218
  Scenario:  HOME - Policy Optional Coverages appear in the modal
    Given I have started a new home policy up to the "auto policy optional coverages" modal
    Then The optional coverages modal should contain the following coverages:
      | Actual Cash Value Loss Settlement                                                                     |
      | Actual Cash Value Loss Settlement - Roof Surface                                                      |
      | Animal - Exclusion Endorsement                                                                        |
      | Assisted Living Care                                                                                  |
      | Business Property - Increased Limit                                                                   |
      | Business Pursuits                                                                                     |
      | Canine - Exclusion Endorsement                                                                        |
      | Contingent Workers Compensation                                                                       |
      | Coverage C - Increased Limits of Liability - Firearms                                                 |
      | Coverage C - Increased Limits of Liability - Jewelry, Watches & Furs                                  |
      | Coverage C - Increased Limits of Liability - Money                                                    |
      | Coverage C - Increased Limits of Liability - Portable Electronic Equipment in or upon a Motor Vehicle |
      | Coverage C - Increased Limits of Liability - Securities                                               |
      | Coverage C - Increased Limits of Liability - Silverware, Goldware & Pewterware                        |
      | Credit Card / Forgery                                                                                 |
      | Dock Coverage                                                                                         |
      | Earthquake                                                                                            |
      | Earthquake Loss Assessment                                                                            |
      | Equipment Breakdown                                                                                   |
      | Farming Personal Liability - Away From Premises                                                       |
      | Functional Replacement Cost Loss Settlement                                                           |
      | Home Business Plus                                                                                    |
      | Hydrostatic Pressure                                                                                  |
      | Identity Fraud Protection                                                                             |
      | Incidental Farming Liability                                                                          |
      | Incidental Low Power Recreational Vehicle                                                             |
      | Inland Flood                                                                                          |
      | Landlord's Furnishings Coverage                                                                       |
      | Liability Extension - Occupied by Insured                                                             |
      | Liability Extension - Rented to Others                                                                |
      | Limited Fungi Wet or Dry Rot or Bacteria Coverage                                                     |
      | Loss Assessment - Additional Locations                                                                |
      | Loss Assessment - Residence Premises                                                                  |
      | Manual Coverage                                                                                       |
      | Motorized Golf Cart - Physical Loss Coverage                                                          |
      | Ordinance or Law - Increased Limit                                                                    |
      | Other Members of Insured's Household Coverage                                                         |
      | Other Structures - Not Specifically Insured - Off Premise                                             |
      | Other Structures - Rented to Others - Residence Premise                                               |
      | Other Structures - Specifically Insured - Off Premise                                                 |
      | Other Structures - Specifically Insured - On Premise                                                  |
      | Other Structures Exclusion Endorsement                                                                |
      | Permitted Incidental Occupancies                                                                      |
      | Personal Cyber Protection                                                                             |
      | Personal Injury                                                                                       |
      | Personal Property Located in a Self-Storage Facility-Increased Limit                                  |
      | Personal Property-Increased Limit-Other Residences                                                    |
      | Plus Ten                                                                                              |
      | Refrigerated Property                                                                                 |
      | Rental Theft                                                                                          |
      | Replacement Cost Loss Settlement of Certain Non-Building Structures                                   |
      | Replacement Cost on Contents                                                                          |
      | Replacement Cost on the Home-Additional Amount                                                        |
      | Residence Employees -Additional Rate for More Than Two Employees                                      |
      | Sinkhole Collapse Coverage                                                                            |
      | Snowmobile Coverage                                                                                   |
      | Special Computer Coverage                                                                             |
      | Special Loss Settlement                                                                               |
      | Sports Plus                                                                                           |
      | Student Away From Home                                                                                |
      | Theft of Building Materials                                                                           |
      | Theft of Personal Property Dwelling Under Construction                                                |
      | Theft of Tools Optional Deductible                                                                    |
      | Utility Line Protection                                                                               |
