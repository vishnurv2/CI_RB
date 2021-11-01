Feature: Verifying data of comparator and PAT system

  @wip
  Scenario: Create a policy and comparator for Home LOB
    Given I login ezlynx account using "valid_creds_ezlynx" fixture
    And I add new ezlynx applicant using "ezlynx_new_applicant" fixture
    And I save the data and click on "GO TO HOME"
    Then I populate general information using "ezlynx_general_info" fixture
    And I click on "POLICY INFO" button on "ez_general_infomation" modal
    Then I populate policy information using "ezlynx_policy_info" fixture
    And I click on "DWELLING INFO" button on "ez_policy_information" modal
    Then I populate dwelling information using "ezlynx_dwelling_info" fixture
    And I click on "COVERAGE" button on "ez_dwelling_information" modal
    Then I populate general coverages using "ezlynx_general_coverages" modal
    And I click on "ENDORSEMENTS" button on "ez_home_coverage_info" modal
    And I click on "CARRIER QUESTIONS" button on "ez_endorsement_information" modal
    And I click on "FINISH" button on "ez_carrier_questions" modal
    And I click on "SUBMIT TO CARRIERS" button on "ez_valid_last_page" modal


  @wip
  Scenario: Ezlynx - Create Auto LOB quote and verify data on PAT system
    Given I login ezlynx account using "valid_creds_ezlynx" fixture
    When I create a new Quote using "ezlynx_pat_t3847" fixture
    And I click on "FINISH" button on "ez_carrier_questions" modal
    And I click on "SUBMIT CARRIERS" button on "ez_submit_to_carrier" modal
    And I click on "SUBMIT" button on "ez_select_carrier_for_auto" modal
    And I click on Answer Questions and Submit
    And I click on "ACCESS QUOTE" button on "ez_quote_results" modal
    Then I switch to Pat system bridge link and verify the premium against Ezlynx
    And I verify mailing address against Ezlynx

    #Then I verify data on PAT system
    #Then I edit the first applicant

