# @markup markdown
# @title Tagging Guidelines

## General
* Tags should always be in lower case.  
* Tags should be placed on the line directly above the feature/scenario.
* Each scenario should be tagged with the test case number

## Common tags and their usage
| Tag           | Usage                                                                                                                                                        |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| @wip          | Used for scenarios that are works in progress and should not be included in a run                                                                            |
| @broken       | Used for scenarios that are broken and should not be included in a run.                                                                                      |
| @fixture_     | Used for loading fixtures with your scenario.  Anything after the fixture_ will be used as the filename.  e.g. @fixture_marketing_business                   |
| @bug_         | Used for indicating the scenario covers a bug in Jira.  The Jira ID of the bug should follow.  e.g. @bug_2252                                                |
| @keep_browser | Used to indicate the browser should be kept around between scenarios.  This is intended to be used on scenario outlines when you're looping through examples |
| @epic_        | Used for indicating the scenario is for a given epic.  The ID of the epic should follow.  e.g. @epic_a                                                       | 
| @story_       | Used for indicating the scenario is for a given story.  The ID of the epic and story should follow.  e.g. @story_a_1                                         |
