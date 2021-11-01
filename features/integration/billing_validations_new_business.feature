Feature: Billing account validations on Billing Statement Page - Legacy

  @delete_when_done @integration
  Scenario: Billing account validations on Billing Statement page Auto
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I fully issue the policy
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

  @delete_when_done @integration
  Scenario: Billing account validations on Billing Statement page - Homeowners
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "home_policy_prefill_issuance"
    Then I have started a new home policy through the "auto policy coverages" modal
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for home
    Then I finish issuing the policies
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

  @delete_when_done @integration
  Scenario: Billing account validations on Billing Statement page - Umbrella
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "umbrella_policy"
    Then I have started a new umbrella policy through the "auto_policy_coverages" modal
    And I begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I resolve any underwriter referrals using blue streak seal or approvals
    Then I finish issuing the policies
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

  @delete_when_done @integration
  Scenario: Billing account validations on Billing Statement page - Dwelling
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "dwelling_policy_issuance"
    Then I have started a new dwelling policy through the "auto policy coverages" modal
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to my quote "Quote Management" using the left nav
    Then I click the begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for home
    Then I finish issuing the policies
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

  @delete_when_done @integration
  Scenario: Billing account validations on Billing Statement page - Watercraft
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "watercraft_policy"
    Then I have created a new "watercraft" policy
    And I add a watercraft operator
    Then I begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    And I resolve any underwriter referrals using blue streak seal or approvals
    Then I finish issuing the policies
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

  @delete_when_done @integration
  Scenario: Billing account validations on Billing Statement page - Scheduled Property
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "scheduled_property_policy_issuance"
    Then I have created a new "scheduled_property" policy
    Then I begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    And I resolve any underwriter referrals using blue streak seal or approvals
    Then I finish issuing the policies
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

  @delete_when_done @integration @wip
  Scenario: Auto policy - Create a billing test that uses a real credit card
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I resolve any underwriter referrals using blue streak seal or approvals
    Then I navigate till billing modal and validate it
    And I populate the billing modal with credit card details
    And I finish issuing the policy after adding billing account
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement
    And I validate credit card details on billing statement

  @delete_when_done @integration @wip
  Scenario: Auto policy - Create a billing test that uses a checking account
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I begin issuance
    When I answer all the underwriting questions
    And I order CLUE and MVR reports for multiple policies
    Then I resolve any underwriter referrals using blue streak seal or approvals
    Then I navigate till billing modal and validate it
    And I populate the billing modal with checking account details
    And I finish issuing the policy after adding billing account
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement
    And I validate checking account details on billing statement

  @delete_when_done @integration
  Scenario: Billing account validations on Billing Statement page Auto - Cancellation
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I fully issue the policy
    When I cancel a policy with reasons in the "policy_cancellation_01" file
    And I close the cancellation modal
    Then the policy should show "Cancel Pending"
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

  @delete_when_done @integration
  Scenario: Billing account validations on Billing Statement page Auto - Non Renew
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I fully issue the policy
    Then I provide a reason in the "policy_non_renew_01" file
    And I close the cancellation modal
    And the policy should show "Issued" with tooltip message includes "Policy is set to Non-Renew"
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

  @delete_when_done @integration
  Scenario: Billing account validations on Billing Statement page Auto - Policy change
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I fully issue the policy
    And I add a policy change and specify the effective date
    And I add another vehicle from the fixture "2010_honda_accord_partial_vin_non_agreed_new"
#    And I assign the primary driver to each vehicle
    Then I resolve any underwriter referrals
    And I navigate to policies "Open Policy Changes" using the left nav
    Then I submit changes
    And I review and submit policy change modal
    And I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

    # 1. Duplicate the above test for all lines of business. rename this file billing_validations_new_business.feature

    # 2. Create a billing test that uses a real credit card ( will provide dummy card number )

    # 3. Renewal - i have no idea how to do this.

    # 3. Policy Change ( billing_validations_policy_change.feature )
    #     Fully issue a policy - initiate a policy change by adding another vehicle. validate new values against billing.
    #     This will likely need to wait on a nightly process ( might be an api we can hit )

    # 4. Cancellation - not sure what there is to check here.
