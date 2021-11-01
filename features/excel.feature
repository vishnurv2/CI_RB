Feature: Reading data through Excel File

  @fixture_SC_01_Create_Auto_Policy_1 @wip
  Scenario: SC_01_Create_Auto_Policy_1
    When I have created a new "auto" policy
    And I fully issue the policy

  @excel_SC_01_Create_Auto_Policy_2 @xlsx_test_data_2 @wip
  Scenario: SC_01_Create_Auto_Policy_2
    When I have created a new "auto" policy
    And I fully issue the policy

  @wip
  Scenario Outline: Create Multiple Auto Policies
    Given I load data from "test_data_2" excel for <test_name>
    When I have created a new "auto" policy
    Examples:
      | test_name                  |
      | SC_01_Create_Auto_Policy_1 |
      | SC_01_Create_Auto_Policy_2 |
      | SC_01_Create_Auto_Policy_3 |
      | SC_01_Create_Auto_Policy_4 |
      | SC_01_Create_Auto_Policy_5 |
      | SC_01_Create_Auto_Policy_6 |
      | SC_01_Create_Auto_Policy_7 |
      | SC_01_Create_Auto_Policy_8 |
      | SC_01_Create_Auto_Policy_9 |
      | SC_01_Create_Auto_Policy_10 |
      | SC_01_Create_Auto_Policy_11 |
      | SC_01_Create_Auto_Policy_12 |
      | SC_01_Create_Auto_Policy_13 |
      | SC_01_Create_Auto_Policy_14 |
      | SC_01_Create_Auto_Policy_15 |

  @wip
  Scenario: Generate YAML files for all data in the excel file
    Given I generate YAML for all keys present in "personal_lines_auto_IN" excel

  @wip
  Scenario Outline: Create Multiple Auto Policies
    Given I load data from "test_data" excel,worksheet as "DataSheet" for <test_name>
    Then I have created a new "auto" policy
    When I add a vehicle from "test_data" excel,worksheet as "atv" for <test_name>
    When I add a vehicle from "test_data" excel,worksheet as "trailer" for <test_name>
    When I add a vehicle from "test_data" excel,worksheet as "camper" for <test_name>
    When I add a vehicle from "test_data" excel,worksheet as "motorhome" for <test_name>
    Examples:
      | test_name                  |
      | SC_01_Create_Auto_Policy_1 |


  @wip
  Scenario Outline: Create Multiple Home Policies
    Given I load data from "test_data_home" excel,worksheet as "DataSheet" for <test_name>
    Then I have created a new "home" policy
    And I fully issue the home policy
    Examples:
      | test_name                  |
      | SC_01_Create_Home_Policy   |
      | SC_02_Create_Home_Policy   |

  @wip
  Scenario Outline: Create Multiple Auto Policies adding driver
    When I add a vehicle from "test_data" excel,worksheet as "motorhome" for <test_name>
    Examples:
      | test_name                  |
      | SC_01_Create_Auto_Policy_1 |

  @wip
  Scenario Outline:Create Multiple Auto Policies adding additional parties
    Given I load data from "test_data" excel,worksheet as "DataSheet" for <test_name>
    Then I have created a new "auto" policy
    And I load additonal party from "test_data" excel,worksheet as "party" for <test_name>
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I validate "Trust" role details and "save and close" the modal
    And I select party type as "Individual" and role as "Trustee" and add new party details
    Then I validate Trustee role details and "save and close" the modal
    And I select party type as "Business Entity" and role as "Loss Payee" and add new party details
    Then I validate "Loss Payee" role details and "save and close" the modal
    And I select party type as "Business Entity" and role as "Additional Interest" and add new party details
    Then I validate "Additional Interest" role details and "save and close" the modal
    Examples:
      | test_name                  |
      | SC_01_Create_Auto_Policy_1 |

  @wip
  Scenario Outline:Create Multiple Auto Policies adding additional parties using fixtures
    Given I load data from "test_data" excel,worksheet as "DataSheet" for <test_name>
    Then I have created a new "auto" policy
    And I have loaded the fixture file named "auto_policy_party_loss_payee"
    And I select party type as "Business Entity" and role as "Trust" and add new party details
    Then I validate "Trust" role details and "save and close" the modal
    Examples:
      | test_name                  |
      | SC_01_Create_Auto_Policy_1 |
