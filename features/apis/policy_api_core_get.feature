@no_browser
Feature: Policy API Core Tests - GET

  Background:
    Given I have requested the account from my fixture file
    And I have requested a token using the credentials from the authorization_server_api file

  ## Driver Assignments
  @fixture_api_demo_3 @policy_api
  Scenario: PolicyApiCore - Driver Assignments - Get ALL driver assignments for a Policy Activity
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the accounts should have a driver assignment

  @fixture_api_demo_3 @policy_api
  Scenario: PolicyApiCore - Driver Assignments - Get a driver assignments for a Policy Activity
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the account should have a driver assignment


  ## Drivers
  @fixture_api_demo_2 @policy_api
  Scenario: PolicyApiCore - Drivers - Get all drivers with NewDriver status for the given policy activity id
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the account should have a driver

    ## do 2nd GET for drivers

  ## Coverages
  @fixture_api_demo_2 @policy_api
  Scenario: PolicyApiCore - Coverages - Get all coverages for policy
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the account should have coverages


  ## Forms
  @fixture_api_demo_2 @policy_api @wip
  Scenario: PolicyApiCore - Forms - Get all coverages for policy
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the policy activity id should have forms available


  ## Vehicles
  @fixture_api_demo_2 @policy_api
  Scenario: PolicyApiCore - Vehicles - Get all vehicles for policy
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the account should have a vehicle

  @fixture_api_demo_2 @policy_api
  Scenario: PolicyApiCore - Vehicles - Gets a vehicle using Policy Activity id and Vehicle Id
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the activity should have a vehicle


  ## General Info
  @fixture_api_demo_4 @policy_api
  Scenario: PolicyApiCore - GeneralInfo - Gets Policy General info using policy activity id
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the account should have basic policy information


  ## Policies
  @fixture_api_demo_2 @policy_api
  Scenario: PolicyApiCore - Policies - Gets basic policy information using policy activity id
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the policy should have basic information


  ## Code Lists
  @fixture_api_demo_2 @policy_api
  Scenario Outline: PolicyApiCore - Code Lists - Coverages - Gets Policy Code Value Lists based on resource name using policy level applicability
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the <method> list should have a data
    Examples:
      | method                  |
      | any_vehicle             |
      | driver_assignment       |
      | driver_model            |
      | general_info            |
      | policy_applicant_modal  |
      | policy_coverages        |


   ## Reports
  @fixture_api_demo_2 @policy_api
  Scenario: PolicyApiCore - Reports - Summary - To get credit report summary
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the response for "get_credit_report_summary" should return a credit score of NOHIT

  @fixture_api_demo_2 @policy_api
  Scenario: PolicyApiCore - Reports - Details - To get credit report details
    When I retrieve the Policy Activity ID based on the account from the fixture
    Then the response for "get_credit_report_details" should return a credit score of NOHIT

