@indiana_auto @personal_auto @extended_transportation @auto
Feature: Extended Transportation

  @delete_when_done @wip @TestCaseKey=PAT-T3639
  Scenario Outline: Extended transportation has different limits based on enhanced auto - autoplus and signature
    Given I have started a new auto policy up to the "auto vehicle coverages" modal using the <fixture_file> fixture
    And I open the vehicle I just added
    Then I <which> have the ability to set the coverage limit for extended transportation
    And I should see <message> for the already included in personal limit for extended transportation
    And I should see <enhanced_message> for the already included limit for extended transportation
    Examples:
      | fixture_file                            | which       | message                    | enhanced_message              |
      | auto_policy_autoplus_combined_none      | should not  | $30 Per Day / $900 Maximum | $30 Per Day/$900 Maximum      |
      | auto_policy_sig_split_none              | should not  | $30 Per Day / $900 Maximum | No Daily Limit/$3,000 Maximum |

  @delete_when_done @regression @wip @TestCaseKey=PAT-T3640
  Scenario Outline: Extended transportation has different limits based on enhanced auto - none and summit
    Given I have started a new auto policy up to the "auto vehicle coverages" modal using the <fixture_file> fixture
    And I open the vehicle I just added
    Then I <which> have the ability to set the coverage limit for extended transportation
    And I should see <message> for the already included in personal limit for extended transportation
    And I should see <enhanced_message> for the already included limit for extended transportation
    Examples:
      | fixture_file                   | which      | message                    | enhanced_message              |
      | auto_policy_none_combined_none | should     | $30 Per Day / $900 Maximum |                               |
      | auto_policy_summit_split_none  | should not | $30 Per Day / $900 Maximum | No Daily Limit/$1,500 Maximum |

  @delete_when_done @regression @wip @TestCaseKey=PAT-T3641
  Scenario Outline: Extended transportation is not available for classic and antique autos
    Given I have started a new auto policy up to the "auto vehicle coverages" modal using the <fixture_file> fixture
    And I open the vehicle I just added
    Then I should not see the extended transportation coverage
    Examples:
      | fixture_file                                    |
      | auto_policy_none_combined_none_classic          |
      | auto_policy_none_combined_none_classic_limited  |
      | auto_policy_none_combined_none_antique          |