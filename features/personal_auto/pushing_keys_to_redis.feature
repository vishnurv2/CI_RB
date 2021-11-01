Feature: Pushing key value pair to Redis

  @no_browser @wip
  Scenario: Pushing key value pair to Redis Server
    Given I load the global excel
    And I delete all existing keys from redis cache
    Then I regenerate the cache