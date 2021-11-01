Feature: PreRenewals and policy changes

  @fixture_home_policy_none_combined_none_pdf_validation @regression @delete_when_done @TestCaseKey=PAT-T5384 @PAT-10769 @homeowners @policy_issuance
  Scenario: Creating a pre-renewal policy
    Given I have created a new "home" policy
    And I fully issue the home policy
    And I save policy number from account summary page
    Then I save policy number to the text file

  #    execute this manually other dayN
  @delete_when_done @wip
  Scenario: verification of pre-renewal details and modals
    Then I have logged in using the credentials from the file "valid_creds"
    Then I navigate to "Account Overview" using the left nav
    Then I save policy number from the text file
    And I search for policy number in the basic search
    Then I select "car_icon" record matching with primary text "policy number"
    And I refresh the page
    And I should see PRE-RENEWAL line should be generated
