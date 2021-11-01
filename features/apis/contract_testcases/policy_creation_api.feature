@no_browser @wip
Feature: Creation of policy with Api

  @fixture_auto_policy_none_split_none
  Scenario: Trailers can be added to auto policies with coverages
    #Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    Given I login to PAT application through Api
    And I create a new mocking service
    Then T verify request and response