Feature: Validating the referrals for homeowners policy

  @fixture_ui_edits_home_sumit @delete_when_done @regression
  Scenario: Verify referral FAMILY > 1 AND SUMMIT POLICY AND RISK-STATE IS NOT NC
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
    |Home must be a one family to qualify for a Summit policy|

  @fixture_ui_edits_home_special @delete_when_done @regression
  Scenario: Verify referral NUM-OF-FAMILIES > 2. All forms except Summit.
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Number of families exceeds two. Underwriter approval is required prior to binding.|

  @fixture_ui_edits_home_summit_condo @delete_when_done @regression
  Scenario: Verify referral SUMMIT CONDO POLICY AND COV-C < 75000 AND RISK-STATE IS NOT NC
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Summit Condo - Coverage C must be at least $75,000.|
      |Tenant / Condo Policy- Coverage C must be at least $20,000.|

  @fixture_ui_edits_summit_homeowners @delete_when_done @regression
  Scenario: Verify referral REPLACEMENT OR REPAIR COST NOT = (25% OR 50%) AND SUMMIT POLICY AND AGE-OF-HOME > 25 AND < 60
    Given I have created a new "home" policy
    And I should see the following referral messages on referrals page
      |The Summit form includes Covg. A- Replacement or Repair Cost- No Limit. Due to the age of the dwelling you must select an optional endorsement of 25% or 50% Specified Additional Amount. You can find this within the Central quote under Optional Endorsements / Replacement Cost on the Home.|

  @fixture_ui_edits_summit_homeowner_age_of_home @delete_when_done @regression
  Scenario: Verify referral REPLACEMENT OR REPAIR COST NOT = 25% AND SUMMIT POLICY AND AGE-OF-HOME > 59
    Given I have created a new "home" policy
    And I should see the following referral messages on referrals page
      |The Summit form includes Covg. A- Replacement or Repair Cost- No Limit. Due to the age of the dwelling you must select an optional endorsement of 25% Specified Additional Amount. You can find this within the Central quote under Optional Endorsements / Replacement Cost on the Home.|

  @fixture_ui_edits_summit_condo_usage_type @delete_when_done @regression
  Scenario: Verify referral SUMMIT POLICY AND USAGE TYPE not equal to PRIMARY,SECONDARY, SEASONAL
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Summit Condo- Condo must be owner-occupied to qualify.|

  @fixture_ui_edits_summit_tenant_policy @delete_when_done @regression
  Scenario: Verify referral COV-C < 50000 AND SUMMIT-TENANT POLICY
    Given I have started a new home policy through the "property info" modal
    When I modify the policy level coverages scrolling by property panel
    And I should see a validation error message "Coverage C - Contents must be at least $50,000" in policy coverage modal

  @fixture_ui_edits_home_special_occasionally_occupied @delete_when_done @regression
  Scenario: Verify referral USAGE-TYPE = OCCASIONALLY OCCUPIED and (Dwelling Use= Secondary, Seasonal, or Occasionally Occupied) AND PACKAGE DISCOUNT = N
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Underwriter approval is required prior to binding a dwelling that is occasionally occupied.|
      |Underwriter approval is required prior to binding a secondary/seasonal/occasionally occupiedhome if he Applicant's primary Homeowner's coverage is not written with Central|

  @fixture_ui_edits_home_special_vacant @delete_when_done @regression
  Scenario: Verify referral USAGE-TYPE = VACANT
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Vacant dwellings are not eligible.|

  @fixture_ui_edits_rating_state_delaware @delete_when_done @regression
  Scenario: Verify referral RISK-STATE IS NOT IN IL, IN, KY, MI, OH, WI
    Given I have started a new home policy up to the "auto general info" modal
    When I click on close button
    And I should see the following referral messages on referrals page
      |Home is located outside of the central region and requires Underwriting approval. Please contact your Underwriter prior to binding.|

  @fixture_ui_edits_home_special @delete_when_done @regression @wip
  Scenario: Verify referral for Wood roof Not Condo or Tenant and all perils deductible less than $1500
    Given I have started a new home policy through the "auto policy coverages" modal
    When I modify the property information modal
    And I modify the roof type to "Wood" in property modal and save and close
    And I should see the following referral messages on referrals page
      |A $1,500 or higher all perils deductible is required on homes with a wood roof.|

  @fixture_ui_edits_home_waterbackup_deductibles @delete_when_done @regression
  Scenario: Verify referral for Increased water backup limit is $44,999 or less and Water Backup deductible is less than $1,000.
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |A minimum Water backup Deductible of $1,000 must be selected on all Water backup endorsements with a total limit equal to $49,999 or less.

  @fixture_ui_edits_home_water_deductible_more @delete_when_done @regression
  Scenario: Verify referral for Increased water backup limit is $45,000 to $95,000 and Water Backup deductible is less than $2,500.
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |A minimum Water backup Deductible of $2,500 must be selected on all Water backup endorsements with a total limit equal to $50,000 to $100,000.|

  @fixture_ui_edits_home_water_deductibles_high @delete_when_done @regression
  Scenario: Verify referral for Increased water backup limit is greater than $95,000 and Water Backup deductible is less than $2,500
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |A minimum Water backup Deductible of $5,000 must be selected on all Water backup endorsements with a total limit greater than $100,000.|

  @fixture_ui_edits_home_special_one_family @delete_when_done @regression
  Scenario: Verify referral for COV-A > or = 1,000,000 and PC 1-7 or 1X-7X or 1Y-7Y.
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Coverage A limit is $1,000,000 or above. Underwriter approval is required prior to binding.|
      |High Value Home - does not have both a Central Station Fire Alarm and a Central Station Burglar Alarm. Underwriter approval is required prior to binding.|

  @fixture_ui_edits_home_signature_policy @delete_when_done @regression
  Scenario: Verify referral for COV-A  < 500,000 and FAMILY > 1 AND Signature POLICY
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Signature Home: Coverage A limit must be at least $500,000 or above. Underwriter approval is required prior to binding.|
      |Home must be a one family to qualify for a Signature policy.                                                          |

  @fixture_ui_edits_home_signature_coverage_A @delete_when_done @regression
  Scenario: Verify referral for COV-A > or = 3,000,000
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Signature Home: Coverage A limit is $3,000,000 or above. Underwriter approval is required prior to binding.|

  @fixture_ui_edits_home_special_ACV @delete_when_done @regression
  Scenario: Verify referral If ACV loss settlement option is selected in the quote.
    Given I have created a new "home" policy
    And I should see the following referral messages on referrals page
      |Underwriter approval is required prior to binding ACV loss settlement.|

  @fixture_ui_edits_home_special_ACV_roof @delete_when_done @regression
  Scenario: Verify referral If ACV roof  loss settlement option is selected in the quote.
    Given I have created a new "home" policy
    And I should see the following referral messages on referrals page
      |Underwriter approval is required prior to binding ACV loss settlement to the roof.|

  @fixture_ui_edits_home_special_loss_settlement @delete_when_done @regression
  Scenario: Verify referral If special loss settlement option is selected in the quote.
    Given I have created a new "home" policy
    And I should see the following referral messages on referrals page
      |Underwriter approval is required prior to binding special loss settlement.|

  @fixture_ui_edits_home_special_functional_cost @delete_when_done @regression
  Scenario: Verify referral If functional replacement cost option is selected in the quote.
    Given I have created a new "home" policy
    And I should see the following referral messages on referrals page
      |Underwriter approval is required prior to binding functional replacement cost.|

  @fixture_ui_edits_effective_date_referral @delete_when_done @regression
  Scenario: Verify referral for EFFECTIVE DATE <= CURRENT DATE - 30
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |The effective date of this quote, 03/21/2021, is backdated 30 days or more.  Underwriting approval is required prior to binding.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Verify referral for COV-A > or = 5,000,000
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Coverage A limit is $1,000,000 or above. Underwriter approval is required prior to binding.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Verify referral for Are any of the dogs listed below, including a mix of one or more of these breeds, in the household?
    Given I have started a new home policy through the "auto policy coverages" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the home underwriting questions "Yes" for "dogs" on premises
    And I should see the following referral messages on referrals page
      |Due to the presence of one or more of the following dog breeds, this risk does not fit Central?s target market: Akita, Alaskan Malamute, Chow, Doberman Pinscher, German Shepherd, Pit Bull, Presa Canario, Rottweiler, Siberian Husky, Wolf or any dog crossed with wolf breed.|
      |Due to the presence of a dog on premise that has attacked, bitten, or caused injury to others, this risk does not fit Central's target market.                                                                                                                                  |

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Verify referral for If question "Are there any exotic pets in the household" is answered yes.
    Given I have started a new home policy through the "auto policy coverages" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the home underwriting questions "Yes" for "exotic pets" in the household
    And I should see the following referral messages on referrals page
      |Due to the presence of an exotic pet on premise, this risk does not fit Central's target market.|

  @fixture_ui_edits_home_summit_trampoline_pool @delete_when_done @regression
  Scenario: Verify referral for swimming pool and trampoline
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Unfenced swimming pools are not eligible. Underwriter approval is required prior to binding this risk.|
      |Trampolines are not eligible. Underwriter approval is required prior to binding this risk.            |

  @fixture_ui_edits_home_special @delete_when_done @regression
  Scenario: Verify referral LLC and Trust party are both present
    Given I have started a new home policy through the "auto policy coverages" modal
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I validate "Trust" role details and "save and close" the modal
    And I select party type as "Business Entity" and role as "LLC" and add new party details
    Then I validate "LLC" role details and "save and close" the modal
    And I should see the following referral messages on referrals page
      |LLC and Trust present, Underwriter approval required.|

  @fixture_ui_edits_home_special_cover_b @delete_when_done @regression
  Scenario: Verify referral for Applies to all forms where Cove B > Cove A. N/A to form 4, 6, T or C and Dwelling Type = Primary AND Primary Heat Type = Fireplace, Non-Professionally Installed
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Coverage B limit is greater than Coverage A limit. Underwriter approval is required prior to binding.|
      |This home's primary heat type is not eligible. Underwriter approval is required prior to binding this risk.|

  @fixture_ui_edits_home_special_secondary @delete_when_done @regression
  Scenario: Verify referral for Dwelling Type = Secondary or Seasonal AND Primary Heat Type = Fireplace, Non-Professionally Installed
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |This home's primary heat type is not eligible. Underwriter approval is required prior to binding this risk.|

  @fixture_ui_edits_home_special @delete_when_done @regression
  Scenario: Verify referral INCORPORATED','CORPORATION', ' CORP ', ' CORP.', 'BUSINESS','INC.', ' INC ', 'COMPANY', ' CO ', 'CO.', 'LLC', 'L.L.C.', 'LLP', 'L.L.P.', 'FLP', 'F.L.P.', 'FLLC', 'F.L.L.C.' present in appl, coappl, addl insured, or addl interest. Not screened for auto if loss payee and addl insured for same vehicle (leased vehicle).
    Given I have started a new home policy through the "auto policy coverages" modal
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Additional Interest" and add new party details
    Then I validate "Additional Interest" role details and "save and close" the modal
    And I should see the following referral messages on referrals page
      |Adding an Additional Interest requires underwriting approval prior to binding.|
      |Underwriter approval is required to add a business or corporation to this policy.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Verify referral for Fuel Tank Location = Indoors Above Ground No Masonry Floor, or Outdoors Below Ground
    Given I have started a new home policy through the "auto policy coverages" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the home underwriting questions "Yes" for "Fuel" storage tank on premises with fuel_tank_questions fixture file
    And I should see the following referral messages on referrals page
      |Due to the fuel storage tank's location, this risk is ineligible. Underwriter approval is required prior to binding this risk.|

  @fixture_ui_edits_condo_exclusively_rented @delete_when_done @regression
  Scenario: IF CONDO EXCLUSIVELY RENTED TO OTHERS IS SELECTED IN QUOTE AND PACKAGE DISCOUNT = N
    Given I have started a new home policy through the "auto policy optional coverages" modal
    And I should see the following referral messages on referrals page
      |A condo exclusively rented to others requires the primary Homeowner's coverage to be written with Central. Underwriter approval is required prior to binding a condo exclusively rented to others if the Applicant's primary Homeowner's coverage is not written with Central.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: AGE-OF-HOME > 40 YEARS WITH REPLACEMENT OR REPAIR COST COVERAGE A = NO LIMIT AND IS BLUE STREAK AND FORM NOT = (S, C, T, 4 OR C)
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Only homes constructed in the past 40 years may be written using Replacement or Repair Cost coverage A no limit.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: ALL PERILS DEDUCTIBLE < $1000 AND FORM 3, 5 OR S
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |A $1,000 minimum deductible is required for new business. Underwriter approval is required prior to binding this quote.|

  @fixture_ui_edits_home_special_8x_protection_class @delete_when_done @regression
  Scenario: COV-A > or = 500,000 and (PC = 1W - 8W, 8X, 8Y, 08, 8B, 09, 10 OR WT)
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Coverage A limit is $500,000 or above. Underwriter approval is required prior to binding.|

  @fixture_ui_edits_home_special_cov_c_greater @delete_when_done @regression
  Scenario: Applies to all forms where Cov C > Cov A. N/A to form 4, 6, T or C.
    Given I have started a new home policy through the "auto policy coverages" modal
    And I should see the following referral messages on referrals page
      |Coverage C limit is greater than Coverage A limit. Underwriter approval is required prior to binding.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Any history of leaking = yes
    Given I have started a new home policy through the "auto policy coverages" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the home underwriting questions "Yes" for "Fuel" storage tank on premises with fuel_tank_questions_1 fixture file
    And I should see the following referral messages on referrals page
      |A fuel storage tank with a history of leaking is not eligible for Central’s Dwelling Program.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Does the homeowner have a Service Contract with their fuel oil dealer that includes a visual inspection of the tank at least annually = No
    Given I have started a new home policy through the "auto policy coverages" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the home underwriting questions "Yes" for "Fuel" storage tank on premises with fuel_tank_question_2 fixture file as no for leak and contract
    And I should see the following referral messages on referrals page
      |This application requires underwriter approval prior to binding due to the fuel storage tank.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Fuel Storage Location = Indoors AND tank age is > 50 years
    Given I have started a new home policy through the "auto policy coverages" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the home underwriting questions "Yes" for "Fuel" storage tank on premises with fuel_tank_questions_3 fixture file as no for leak and contract
    And I should see the following referral messages on referrals page
      |Due to the age of the fuel storage tank, this risk is not eligible for Central’s Dwelling Program.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Fuel Storage Location = Outdoors and tank age is >25 years.
    Given I have started a new home policy through the "auto policy coverages" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the home underwriting questions "Yes" for "Fuel" storage tank on premises with fuel_tank_questions_4 fixture file as no for leak and contract
    And I should see the following referral messages on referrals page
      |Due to the age of the fuel storage tank, this risk is not eligible for Central’s Dwelling Program.|

  @fixture_ui_edits_home_special_coverage_not_blue_streak @delete_when_done @regression
  Scenario: Verify referral for AGE-OF-HOME > 25 YEARS WITH REPLACEMENT OR REPAIR COST COVERAGE A = NO LIMIT AND IS NOT BLUE STREAK AND FORM NOT = (S, C, T, 4 OR 6)
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Only homes constructed in the past 25 years may be written using Replacement or Repair Cost coverage A no limit.|

  @fixture_ui_edits_home_signature_policy_protection_class_10 @delete_when_done @regression
  Scenario: Verify referral for (PC = 10 OR WT) AND Signature Form
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Protection Class 10 requires underwriter approval.|

  @fixture_ui_edits_home_summit_policy_protection_class_10 @delete_when_done @regression
  Scenario: Verify referral for (PC = 10 OR WT) AND Summit Form
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Protection Class 10 requires underwriter approval.|

  @fixture_ui_edits_home_special_coverage_Log @delete_when_done @regression
  Scenario: Verify referral for CONSTRUCTION-TYPE IS LOG
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Log homes are not eligible.|

  @fixture_ui_edits_home_summit_policy_protection_class_10 @delete_when_done @regression
  Scenario: Verify referral MORTGAGEES = 3 AND PPC = 10
    Given I have started a new home policy through the "property info" modal
    Then I navigate to "Account Overview" using the left nav
    And I select party type as "Business Entity" and role as "Mortgagee" and add new party details
    Then I validate "Mortgagee" role details and "save and close" the modal
    And I select party type as "Business Entity" and role as "Mortgagee" and add new party details
    Then I validate "Mortgagee" role details and "save and close" the modal
    And I select party type as "Business Entity" and role as "Mortgagee" and add new party details
    Then I validate "Mortgagee" role details and "save and close" the modal
    And I should see the following referral messages on referrals page
      |3 mortgagees and PPC 10. Underwriter approval is required prior to binding this risk.|

  @fixture_ui_edits_home_special_coverage_spec_home @delete_when_done @regression
  Scenario: Verify referral for Spec Home = Yes and Is the applicant the general contractor = Yes
    Given I have started a new home policy through the "property info" modal
    And I should see the following referral messages on referrals page
      |Spec homes are not eligible. Underwriter approval is required prior to binding this risk.|
      |Risks where the homeowner presides as the general contractor are not eligible. Underwriter approval is required prior to binding this risk.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Verify referral for Work From Home Commercial Insurance = Yes
    Given I have started a new home policy through the "property info" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the home underwriting questions "Yes" for "work from home" residents in underwriting questions
    And I should see the following referral messages on referrals page
      |In-home business exposures without commercial insurance require underwriter approval prior to binding.|

  @fixture_ui_edits_home_special_coverage @delete_when_done @regression
  Scenario: Verify referral for Any Flooding, Brush, Forest Fire Hazard, Landslide ect. = Yes
    Given I have started a new home policy through the "property info" modal
    And I navigate to "Underwriting Questions" tab on quote management page
    When I answer the home underwriting questions "Yes" for "flooding, brush, forest fire" in underwriting questions
    And I should see the following referral messages on referrals page
      |Underwriter approval is required prior to binding a home located in a flooding, brush, forest fire or landslide hazard area.|



