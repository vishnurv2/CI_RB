@no_browser
Feature: Account API Core Tests - GET

  Background:
    Given I have requested the account from my fixture file
    And I have requested a token using the credentials from the authorization_server_api file

  ## Accounts
  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - Accounts - Get Account Information
    Then the Account ID in the response should match the account from the fixture file

  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - Accounts - Contact Details - Get all emails and phone numbers associated with an account
    Then the Account should have a valid phone number

  ## Account Parties
  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - AccountParties - Get Account Party Information
    Then the Account should have at least one person

  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - AccountParties - Get Account Parties
    Then the account party should have valid data

  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - AccountParties - Get Account Parties filtered by role
    Then the account party should have data and a role of "Applicant"

  ## Addresses
  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - Addresses - Get Account Addresses
    Then the Account should have a valid address

  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - Addresses - Usages - Get Account Addresses Usage
    Then the Account should have a primary address usage

  ## Code Lists
  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - CodeLists - accounts - Get Code value lists based on path
    Then the "accounts" code list should have a name and child items

  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - CodeLists - applicants - Get Code value lists based on path
    Then the "applicants" code list should have a name and child items

  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - CodeLists - cancel_nonrenew - Get Code value lists based on path
    Then the "cancel_non_renew" code list should have a name and child items

  ## General Info
  @fixture_api_demo_5 @account_api
  Scenario: AccountApiCore - GeneralInfo - Get Account General Info
    Then the Account should have agency data

  ## Policy Summaries
  @fixture_api_demo_2 @account_api
  Scenario: AccountApiCore - PolicySummaries - Get Account PolicySummaries
    Then the Account should have an incomplete quote