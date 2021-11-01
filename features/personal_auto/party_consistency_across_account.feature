@auto @driver
Feature: Party Consistency

  #new applicant modal does not have existing party dropdown
  @delete_when_done @TestCaseKey=PAT-T247 @known_issue
  Scenario: Drivers Added on the Second Policy Appear as Applicants
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add a product from the left nav
    And I add an additional product using the generic_account_info fixture
    And I have loaded the fixture file named "driver_consistency"
    When I add a driver from the policy summary page using the data for "additional driver"
    And I navigate to "Account Overview" using the left nav
    And I start adding an applicant from the account summary page
    Then The driver from the data for "additional_driver/auto_driver_modal" should appear in the add applicant dropdown

#    existing_parties does not exist on New party modal. Hence last step needs to be modified
  @delete_when_done @TestCaseKey=PAT-T246 @known_issue
  Scenario: Drivers Added on a Policy Appear as Applicants on Different Policies
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add a product from the left nav
    And I add an additional product using the generic_account_info fixture
    And I have loaded the fixture file named "driver_consistency"
    When I add a driver from the policy summary page using the data for "additional driver"
    And I navigate to "IN - Auto" using the left nav
    And I start adding an applicant from the auto summary page
    Then The driver from the data for "additional_driver/auto_driver_modal" should appear in the add applicant dropdown

    # these can be added back into the suite once the YML post deploy is retired and the Excel Data Driven post deploy is running
  @delete_when_done @TestCaseKey=PAT-T248 @wip
  Scenario: Drivers Added on a Policy Appear as a Driver on a Different Policy
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add a product from the left nav
    And I add an additional product using the generic_account_info fixture
    And I have loaded the fixture file named "driver_consistency"
    When I add a driver from the policy summary page using the data for "additional driver"
    And I navigate to "IN - Auto" using the left nav
    And I start adding a driver on the policy summary page
    Then The driver from the data for "additional_driver/auto_driver_modal" should appear in the add driver dropdown

#    Works only on excel driven framework
  @delete_when_done @TestCaseKey=PAT-T250 @wip
  Scenario: Applicants Added on a Policy Appear on a Different Policy
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I add a product from the left nav
    And I add an additional product using the generic_account_info fixture
    And I have loaded the fixture file named "applicant_consistency"
    When I add another applicant from the auto summary page
    And I navigate to "IN - Auto" using the left nav
    And I start adding a driver on the policy summary page
    Then The driver from the data for "additional_applicant/add_applicant_modal" should appear in the add driver dropdown

    #    Works only on excel driven framework
  @delete_when_done @TestCaseKey=PAT-T249 @wip
  Scenario: Applicants Added on an Account Appear on a Policy
    Given I have created a new "Auto" policy via the API with data in the api_add_account fixture
    And I have loaded the fixture file named "account_summary_applicant_consistency"
    When I navigate to "Account Overview" using the left nav
    And I add another applicant from the account summary page
    And I navigate to "IN - Auto" using the left nav
    And I start adding a driver on the policy summary page
    Then The driver from the data for "additional_applicant/add_applicant_modal" should appear in the add driver dropdown


