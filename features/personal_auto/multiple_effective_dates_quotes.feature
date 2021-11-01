@wip
Feature: Multiple Effective Dates Quotes
  # this should never run as part of the suite, it is intended for selecting specific effective dates

  @delete_when_done
  Scenario Outline: Validation of product status after navigating to quote management page
    Given I have created a new "auto" policy using the <fixture_file> fixture and an effective date of "<effective_date>"
    And I open and save the coverages
    When I navigate to "Account Overview" using the left nav
    Then the product status should be "Incomplete Quote"
    And I navigate to "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    And I navigate to "Account Overview" using the left nav
    Then the product status should be "Quoted"
    Examples:
      | fixture_file                                | effective_date |
      | auto_policy_autoplus_combined_none_full_vin | 05/20/2021     |