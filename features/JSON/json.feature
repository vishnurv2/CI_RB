Feature: JSON reader

  Background:
    Given I have requested a token using the credentials from the authorization_server_api file

  @json_input @no_browser
  Scenario: Validate Migrated Policy for JSON 1
    Given I have loaded the json file and made modification
    When I create policy using json data
    Then I validate the response

  @json_input_25_05_2021
  Scenario: Validate Migrated Policy for JSON input_25_05_2021
    Given I have loaded the json file and made modification
    #Given I load the json file without modification
    When I saved the modified file
    When I create policy using json data
    Then I saved the response file
    Then I validate the response
    And I click on "Deductible is required" on issue to resolve
    And I provide Deductible in coverage modal
    And I resolve the vehicle issue
    And I Answered Underwriter Questions and OrderReports

  @json_input_26_05_2021_3
  Scenario: Validate Migrated Policy for JSON input_26_05_2021_3
    Given I have loaded the json file and made modification for renewal
    #Given I load the json file without modification
    When I saved the modified file
    When I create policy using json data
    Then I saved the response file
    Then I validate the response
    And I issue the json policy using API
    And I gather account and policy numbers for "IN - Summit Auto" for fully issued json policy
    Then I saved the "Quote" pdf
    Then I save the XML

  @json_input_26_05_2021_2
  Scenario: Validate Migrated Policy for JSON input_26_05_2021_2
    Given I have loaded the json file and made modification for renewal
    #Given I load the json file without modification
    When I saved the modified file
    When I create policy using json data
    Then I saved the response file
    Then I validate the response
    And I issue the json policy using API
    And I gather account and policy numbers for "IN - Auto Plus" for fully issued json policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML

  @json_input_30_06_2021
  Scenario: Validate Migrated Policy for JSON input_30_06_2021
    Given I have loaded the json file and made modification for renewal
    #Given I load the json file without modification
    When I saved the modified file
    When I create policy using json data
    Then I saved the response file
    Then I validate the response
    And I issue the json policy using API
    And I gather account and policy numbers for "IN - Auto Plus" for fully issued json policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I save the XML

    Scenario: Validate Migrated policy using basic search
      Given I have searched the policy "3580255" using basic search


