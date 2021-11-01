Feature: Billing account PDF validation after nightly cycle
# Todo: needs test case Key
  @fixture_auto_policy_applicants_details @delete_when_done @wip
  Scenario: Billing test - save policy number to text file
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I save policy number from account summary page
    Then I save policy number to the text file

# Todo: needs test case Key
#    execute this manually other day
  @delete_when_done @wip
  Scenario: Billing test - Nightly cycle - validation of policy on billing statement
    Given I login legacy account using "valid_creds" fixture
    Then I have logged in using the credentials from the file "valid_creds"
    Then I navigate to "Account Overview" using the left nav
    Then I save policy number from the text file
    And I search for policy number in the basic search
    Then I select "car_icon" record matching with primary text "policy number"
    And I refresh the page
    Then I save billing account details
    And I navigate to "View Billing Statement"
    Then I validate payor and account details on billing statement

    # all lines of business - get a test for .

    # renewal - i have no idea how to do this.

    # cancellation
