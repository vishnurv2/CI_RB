Feature: Billing account validations on Billing Statement Page(Saturn)

  # Todo: needs test case Key
  @delete_when_done @wip
  Scenario: Billing account validations on Billing Statement page
    Given I login legacy account using "valid_creds" fixture
    And I have loaded the fixture file named "auto_policy_autoplus_combined_none_full_vin"
    Then I have created a new "Auto" policy
    And I fully issue the policy
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

    # all lines of business - get a test for .

    # renewal - i have no idea how to do this.

    # cancellation