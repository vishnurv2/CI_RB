Feature: Verifying data of PL rating and PAT system

  @wip
  Scenario: PL Rating - Create HomeLOB quote and verify data on PAT system
    Given I login PL Rating account using "valid_creds_pl_rating" fixture
    #And I complete carrier setup using "ezlynx_carrier_setup" fixture
   # And I click "new_applicant" button on "client_selection" modal
    And I click new applicant and populate client information using "plrating_client_information" fixture
    When I click New Home Quote
    And I select company and click next button
    And I click ok for protection class popup
    And I populate home gen information using "plrating_home_general_info" fixture
    And I populate home property information using "plrating_home_property_info" fixture
    And I populate home coverage information using "plrating_home_coverage_info" fixture
    And I navigate to Rating page via additional info page and click on carrier link
    Then I switch to Pat system bridge link and verify the premium








