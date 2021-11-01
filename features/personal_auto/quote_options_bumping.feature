@auto @account_management
Feature: Quote Options Bumping

  @delete_when_done @TestCaseKey=PAT-T321
  Scenario Outline: Autoplus can be applied via the quote options page autoplus
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    And I navigate to "Quote Management" using the left nav
    When I upgrade enhanced auto coverage from the quote options page to "Summit"
    And I navigate to "IN - Summit" using the left nav
    Then the auto policy will have the enhanced auto coverages we selected from the quote options
    Examples:
      | fixture_file                       |
      | auto_policy_autoplus_combined_none |

  @delete_when_done @regression @TestCaseKey=PAT-T306
  Scenario Outline: Enhanced auto can be applied via the quote options page combined none
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    And I navigate to "Quote Management" using the left nav
    When I upgrade enhanced auto coverage from the quote options page to "Signature"
    And I navigate to "IN - Signature" using the left nav
    Then the auto policy will have the enhanced auto coverages we selected from the quote options
    Examples:
      | fixture_file                       |
      | auto_policy_none_combined_none     |

  @delete_when_done @regression @TestCaseKey=PAT-T318
  Scenario Outline: Enhanced auto can be applied via the quote options page summit
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    And I navigate to "Quote Management" using the left nav
    When I upgrade enhanced auto coverage from the quote options page to "Signature"
    And I navigate to "IN - Signature" using the left nav
    Then the auto policy will have the enhanced auto coverages we selected from the quote options
    Examples:
      | fixture_file                       |
      | auto_policy_summit_combined_none   |

  @delete_when_done @TestCaseKey=PAT-T309
  Scenario Outline: Verify Panel 1 and 2 Bumping Autoplus Combined None
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_autoplus_combined_none_4      |

  @delete_when_done @regression @TestCaseKey=PAT-T304
  Scenario Outline: Verify Panel 1 and 2 Bumping Autoplus Split Uninsured
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_autoplus_split_uninsured_1    |

  @delete_when_done @regression @TestCaseKey=PAT-T322
  Scenario Outline: Verify Panel 1 and 2 Bumping Combined Uninsured
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_none_combined_uninsured       |

  @delete_when_done @regression @TestCaseKey=PAT-T317
  Scenario Outline: Verify Panel 1 and 2 Bumping Auto Split Uninsured
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_none_split_uninsured_4        |

  @delete_when_done @regression @TestCaseKey=PAT-T310
  Scenario Outline: Verify Panel 1 and 2 Bumping Signature Combined None
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_sig_combined_none_1           |

  @delete_when_done @regression @TestCaseKey=PAT-T312
  Scenario Outline: Verify Panel 1 and 2 Bumping Signature Split Uninsured
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_sig_split_uninsured_1         |

  @delete_when_done @regression @TestCaseKey=PAT-T313
  Scenario Outline: Verify Panel 1 and 2 Bumping Summit Combined None
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_summit_combined_none_1        |

  @delete_when_done @regression @TestCaseKey=PAT-T305
  Scenario Outline: Verify Panel 1 and 2 Bumping Summit Split Uninsured
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_summit_split_uninsured_1      |

  @delete_when_done @regression @TestCaseKey=PAT-T319
  Scenario Outline: Verify Panel 1 and 2 Bumping Autoplus Combined Uninsured
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_autoplus_combined_uninsured_1 |

  @delete_when_done @regression @TestCaseKey=PAT-T308
  Scenario Outline: Verify Panel 1 and 2 Bumping Autoplus Split None
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_autoplus_split_none_1         |

  @delete_when_done @regression @TestCaseKey=PAT-T320
  Scenario Outline: Verify Panel 1 and 2 Bumping Auto None Combined None
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_none_combined_none_1          |

  @delete_when_done @regression @TestCaseKey=PAT-T307
  Scenario Outline: Verify Panel 1 and 2 Bumping Auto None Split Uninsured
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_none_split_uninsured_3        |


  @delete_when_done @regression @TestCaseKey=PAT-T315
  Scenario Outline: Verify Panel 1 and 2 Bumping Signature Combined Uninsured
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_sig_combined_uninsured        |

  @delete_when_done @regression @TestCaseKey=PAT-T311
  Scenario Outline: Verify Panel 1 and 2 Bumping Signature Split None
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_sig_split_none_1              |

  @delete_when_done @regression @TestCaseKey=PAT-T303
  Scenario Outline: Verify Panel 1 and 2 Bumping Summit Combined Uninsured
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_summit_combined_uninsured_1   |

  @delete_when_done @regression @TestCaseKey=PAT-T316
  Scenario Outline: Verify Panel 1 and 2 Bumping Summit Split None
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then panel two should contain the correct upgrades
    And any differences between panel one and panel two should be highlighted
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_summit_split_none_1           |

  @fixture_auto_policy_no_liability @delete_when_done @regression @TestCaseKey=PAT-T314
  Scenario: Quote options shows correct bumping values for vehicle coverages
    Given I have created a new "Auto" policy
    When I navigate to "Quote Management" using the left nav
    Then Panel 2 should display upgrades for liability, collision, and other than collision
