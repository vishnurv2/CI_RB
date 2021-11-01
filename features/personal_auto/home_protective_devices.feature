@homeowners @new_business
Feature: Home - Protective devices and water backup

  @delete_when_done @TestCaseKey=PAT-T3577
  Scenario Outline:  Home - Protective devices and water backup type 3 special
    Given I have created a new "home" policy through "auto policy coverages" modal using the <fixture_file> fixture
    And I click on modify auto policy coverages panel
    And I populate and save and close the auto policy coverages using "water_backup_selected" fixture
    Then I check the premium displayed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_protective_devices" fixture
    Then I check the premium displayed and verify that it got changed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_unselected" fixture
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    Examples:
      | fixture_file                                            |   story           |
      | home_policy_type_3_special                              |   PAT-6844        |

  @delete_when_done @TestCaseKey=PAT-T18 @regression
  Scenario Outline:  Home - Protective devices and water backup type 4 tenants
    Given I have created a new "home" policy through "auto policy coverages" modal using the <fixture_file> fixture
    And I click on modify auto policy coverages panel
    And I populate and save and close the auto policy coverages using "water_backup_selected" fixture
    Then I check the premium displayed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_protective_devices" fixture
    Then I check the premium displayed and verify that it got changed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_unselected" fixture
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    Examples:
      | fixture_file                                            |   story           |
      | home_policy_type_4_tenants                              |   PAT-6844        |

  @delete_when_done @TestCaseKey=PAT-T2093 @regression
  Scenario Outline:  Home - Protective devices and water backup type 5 comprehensive
    Given I have created a new "home" policy through "auto policy coverages" modal using the <fixture_file> fixture
    And I click on modify auto policy coverages panel
    And I populate and save and close the auto policy coverages using "water_backup_selected" fixture
    Then I check the premium displayed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_protective_devices" fixture
    Then I check the premium displayed and verify that it got changed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_unselected" fixture
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    Examples:
      | fixture_file                                            |   story           |
      | home_policy_type_5_comprehensive                        |   PAT-6844        |

  @delete_when_done @TestCaseKey=PAT-T2092 @regression
  Scenario Outline:  Home - Protective devices and water backup type 6 condominium
    Given I have created a new "home" policy through "auto policy coverages" modal using the <fixture_file> fixture
    And I click on modify auto policy coverages panel
    And I populate and save and close the auto policy coverages using "water_backup_selected" fixture
    Then I check the premium displayed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_protective_devices" fixture
    Then I check the premium displayed and verify that it got changed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_unselected" fixture
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    Examples:
      | fixture_file                                            |   story           |
      | home_policy_type_6_condominium                          |   PAT-6844        |

  @delete_when_done @TestCaseKey=PAT-T2091 @regression
  Scenario Outline:  Home - Protective devices and water backup type 5s summit homeowners
    Given I have created a new "home" policy through "auto policy coverages" modal using the <fixture_file> fixture
    And I click on modify auto policy coverages panel
    And I populate and save and close the auto policy coverages using "water_backup_selected" fixture
    Then I check the premium displayed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_protective_devices" fixture
    Then I check the premium displayed and verify that it got changed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_unselected" fixture
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    Examples:
      | fixture_file                                            |   story           |
      | home_policy_type_5s_summit_homeowners                   |   PAT-6844        |

  @delete_when_done @TestCaseKey=PAT-T2090 @regression
  Scenario Outline:  Home - Protective devices and water backup type 6c summit condo owners
    Given I have created a new "home" policy through "auto policy coverages" modal using the <fixture_file> fixture
    And I click on modify auto policy coverages panel
    And I populate and save and close the auto policy coverages using "water_backup_selected" fixture
    Then I check the premium displayed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_protective_devices" fixture
    Then I check the premium displayed and verify that it got changed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_unselected" fixture
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    Examples:
      | fixture_file                                            |   story           |
      | home_policy_type_6c_summit_condo_owners                 |   PAT-6844        |

  @delete_when_done @TestCaseKey=PAT-T2089 @regression
  Scenario Outline:  Home - Protective devices and water backup type 4t summit tenant
    Given I have created a new "home" policy through "auto policy coverages" modal using the <fixture_file> fixture
    And I click on modify auto policy coverages panel
    And I populate and save and close the auto policy coverages using "water_backup_selected" fixture
    Then I check the premium displayed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_protective_devices" fixture
    Then I check the premium displayed and verify that it got changed
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_unselected" fixture
    And I click on modify auto policy coverages panel
    Then I verify the details present on auto policy coverages modal
    Examples:
      | fixture_file                                            |   story           |
      | home_policy_type_4t_summit_tenant                       |   PAT-6844        |

  @fixture_home_policy_type_5g_signature_homeowners @delete_when_done @PAT-6844 @PAT-7771 @regression @TestCaseKey=PAT-T301
  Scenario:  Home - Protective devices and water backup for 5G - signature
    Given I have started a new home policy through the "auto policy coverages" modal
    And I click on modify auto policy coverages panel
    And I populate and save and close the auto policy coverages using "water_backup_selected_disabled" fixture
    Then I check the premium displayed
    And I click on modify auto policy coverages panel
    Then I verify the disabled water backup details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_disabled_protective_devices" fixture
    #Then I check the premium displayed and verify that it is same
    And I click on modify auto policy coverages panel
    Then I verify the disabled water backup details present on auto policy coverages modal
    When I populate and save and close the auto policy coverages using "water_backup_protective_devices_unselected" fixture
    And I click on modify auto policy coverages panel
    Then I verify the disabled water backup details present on auto policy coverages modal