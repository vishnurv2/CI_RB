@quote_options @auto @account_management
Feature: Quote options page

  @regression @fixture_quote_options_existing_auto_autoplus_combined_none_2 @TestCaseKey=PAT-T3369 @delete_when_done
  Scenario: Option panels have expanding sections
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    When I navigate to "Quote Management" using the left nav
    Then I should be able to expand and collapse the upsell panels for each quote option

  @delete_when_done @TestCaseKey=PAT-T3370
  Scenario Outline: Limits can be changed via the quote options
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    And I navigate to "Quote Management" using the left nav
    When I select a different limit on the quote options page
    Then the auto policy will have the new limit we selected from the quote options
    Examples:
      | fixture_file                       |
      | auto_policy_autoplus_combined_none |

  @delete_when_done @TestCaseKey=PAT-T3371
  Scenario Outline: Limits can be changed via the quote options split none
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    And I navigate to "Quote Management" using the left nav
    When I select a different limit on the quote options page
    Then the auto policy will have the new limit we selected from the quote options
    Examples:
      | fixture_file                    |
      | auto_policy_autoplus_split_none |

  @regression @TestCaseKey=PAT-T3372 @delete_when_done
  Scenario Outline: Quote options panel - auto autoplus
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                         |
      | quote_options_existing_auto_autoplus_combined_none_3 |

  @regression @TestCaseKey=PAT-T5196 @delete_when_done
  Scenario Outline: Quote options panel - auto signature
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                         |
      | quote_options_existing_auto_sig_split_uninsured_3    |

  @regression @TestCaseKey=PAT-T3373 @delete_when_done
  Scenario Outline: Quote options panel with one fixture
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                        |
      | quote_options_existing_auto_none_combined_uninsured |

  @regression @TestCaseKey=PAT-T3374 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto autoplus combined uninsured 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                              |
      | quote_options_existing_auto_autoplus_combined_uninsured_2 |

  @regression @TestCaseKey=PAT-T3375 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto summit combined uninsured 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                            |
      | quote_options_existing_auto_summit_combined_uninsured_2 |

  @regression @TestCaseKey=PAT-T3376 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto autoplus split none 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                      |
      | quote_options_existing_auto_autoplus_split_none_2 |

  @regression @TestCaseKey=PAT-T3377 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto autoplus split uninsured 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                           |
      | quote_options_existing_auto_autoplus_split_uninsured_2 |

  @regression @TestCaseKey=PAT-T3378 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto none combined none 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                     |
      | quote_options_existing_auto_none_combined_none_2 |

  @regression @TestCaseKey=PAT-T3379 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto none split none 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                  |
      | quote_options_existing_auto_none_split_none_2 |

  @regression @TestCaseKey=PAT-T3380 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto none split uninsured 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                       |
      | quote_options_existing_auto_none_split_uninsured_2 |

  @regression @TestCaseKey=PAT-T3381 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto sig combined none 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                    |
      | quote_options_existing_auto_sig_combined_none_2 |

  @regression @TestCaseKey=PAT-T3382 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto sig split none 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                 |
      | quote_options_existing_auto_sig_split_none_2 |

  @regression @TestCaseKey=PAT-T3383 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto sig split uninsured 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                      |
      | quote_options_existing_auto_sig_split_uninsured_2 |

  @regression @TestCaseKey=PAT-T3384 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto summit combined none 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                       |
      | quote_options_existing_auto_summit_combined_none_2 |

  @regression @TestCaseKey=PAT-T3385 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto summit split none 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                    |
      | quote_options_existing_auto_summit_split_none_2 |

  @regression @TestCaseKey=PAT-T3386 @delete_when_done
  Scenario Outline: Quote Options Panel 1 Coverages and Panel 2 Upgrades - auto summit split uninsured 2
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    When I navigate to "Quote Management" using the left nav
    Then each panel should include a premium
    And panel one should include the coverages from our fixture
    And panel two should include upgrades for the coverages from our fixture
    Examples:
      | fixture_file                                         |
      | quote_options_existing_auto_summit_split_uninsured_2 |

    #below scenarios can not be implemented currently since these functionalities are not there yet in PAT Application
  @delete_when_done @regression @wip @hold @TestCaseKey=PAT-T3387
  Scenario Outline: Applying quote options saves
    Given I have created a new "Auto" policy using the <fixture_file> fixture
    And I navigate to "Quote management" using the left nav
    When I toggle the <applicable_discounts>
    And I navigate to "Quote options" using the left nav
    Then panel one and two should include the <selected_discounts> driver discounts
    Then panel three should show the selected driver discounts <selected_discounts> selected
    Examples:
      | fixture_file                                | applicable_discounts                             | selected_discounts                                                                       |
      | auto_policy_none_combined_none_young_driver | Student away at school, Teen Smart Certification | Good Student, Student away at school, Teen Smart Participation, Teen Smart Certification |
      | auto_policy_none_combined_none_new_driver   | Good Student, Teen Smart Certification           | Student away at school, Teen Smart Participation                                         |
