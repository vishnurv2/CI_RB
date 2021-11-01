@auto @policy_change
Feature: Policy Change - Do not allow change - Transfer

    # seeing full page exceptions when logging into an existing account as an agent during full suite runs
    # we are expecting Angular and the API break out to resolve this
  @regression @fixture_auto_policy_none_combined_none_adjusted @PAT-4247 @delete_when_done @TestCaseKey=PAT-T3564
  Scenario: Policy Change - Check transfer options are disabled
    Given I have created a new "Auto" policy
    And I fully issue the policy
    #And I have logged in using the credentials from the file "agent_creds"
    And I save the url of created policy and logout from the agent account and login as a CMI employee with "agent_creds"
    #And I have opened the account summary opened previously
    When I navigate to policies "In-Auto" using the left nav
    And I click on "Create Policy Change" from Actions dropdown
    #And I click the "Policy Changes" tab
    Then I add a policy change with "Specify Date"
    When I navigate to policies "IN - Auto" using the left nav
    #Then I should be able to validate that the transfer information options are disabled for the Agent

  #    Options to be checked:
  #    Is this part a formal transfer/book roll to Central
  #    Is this a formal re-market/new business dau
  #    Prior Carrier
  #    Prior Premium (annual)
