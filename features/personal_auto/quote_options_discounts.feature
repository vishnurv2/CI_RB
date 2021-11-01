@indiana_auto @personal_auto @quote_options
Feature: Quote option discounts

#below scenarios can not be implemented currently since these functionalities are not there yet in PAT Application
  @regression @wip @hold @delete_when_done @TestCaseKey=PAT-T3549
  Scenario Outline: Quote options shows included driver discounts
    Given I open the existing policy from <fixture_file> fixture
    When I navigate to "Quote options" using the left nav
    Then panel one and two should include the <discounts> driver discounts
    Examples:
      | fixture_file                                                | discounts                                                                                |
      | quote_options_existing_auto_none_combined_none_young_driver | Good Student, Teen Smart Participation                                                   |
      | quote_options_existing_auto_none_combined_none_new_driver   | Good Student, Student away at school, Teen Smart Participation, Teen Smart Certification |

  @regression @wip @hold @delete_when_done @TestCaseKey=PAT-T3550
  Scenario Outline: Quote options shows applicable driver discounts
    Given I open the existing policy from <fixture_file> fixture
    When I navigate to "Quote options" using the left nav
    Then panel three should show the applicable driver discounts <applicable_discounts> with the selected driver discounts <selected_discounts> selected
    Examples:
      | fixture_file                                                | applicable_discounts                                                                     | selected_discounts                                                                       |
      | quote_options_existing_auto_none_combined_none_young_driver | Good Student, Student away at school, Teen Smart Certification, Teen Smart Participation | Good Student, Teen Smart Participation                                                   |
      | quote_options_existing_auto_none_combined_none_new_driver   | Good Student, Student away at school, Teen Smart Certification, Teen Smart Participation | Good Student, Student away at school, Teen Smart Participation, Teen Smart Certification |
