# @markup markdown
# @title Introduction
# Central Insurance PAT Cucumber Framework

Note: All documents in this suite are written in Markdown. Markdown is easily readable without formatting applied, it's much more pleasant to view it with formatting applied.
The RubyMine editor will display it properly, or you can generate the full HTML documentation by running `rake yard` in the root folder of this suite.  Once complete, you can open doc\index.html in your browser.  The READMEs will be in the `files` section of that documentation. 

## Overview
This project contains the [Cucumber](https://github.com/cucumber/cucumber-ruby) test suite for the Policy Admin Transformation team with Central insurance.
Step definitions and other support code are written in [Ruby](https://www.ruby-lang.org/en/), a friendly felixble language.
If you do not already have Ruby on your machine, an installer exists in the tools folder of this repo.

Communication with the browser is handled via the Watir gem (Libraries in Ruby are called gems) which uses a driver application for each browser brand.
The Windows drivers for each browser are in the drivers folder of this repo and will automatically be added to your path when the suite is run.

## First time setup
After installing ruby, you will need to install Bundler via the commandline with:

`gem install bundler`

If you use the included scripts for running the suite, they'll take care of pulling the libraries needed.  If you plan on running cucumber directly, you should run `bundle install` each time you pull the latest source.

If you intend on running against your local machine, you will need to generate policies for the tests that need to work with existing policies. Run the following once to generate the required fixtures: `script\linear_run -p local -p kb features\generate_policy.feature`


## Running the tests
Execute `script\linear_run -p TEST_ENV` from the root folder of the test suite where TEST_ENV is either dev, test or local.
This batch file makes sure that the `should_run` profile is set and ensures that both json and "pretty" results are generated.
Any arguments given to this batch file will be passed on to Cucumber.

Tests can be executed in parallel by executing `script\parallel_run` like the above script this ensures that the `should_run` profile is passed.
Unlike the linear run, this script only outputs json results.  After the run completes, the multiple json result files will be merged into one json file called `merged_results.json`.

Tests can also be executed by running cucumber directly with `bundle exec cucumber` and passing options directly.  When using this method you will need to set all command line options yourself.

Running any of the above will run all tests found under the `features` folder that match our tag selection if any.

Running in parallel can also be achieved by running  `bundle exec parallel_cucumber`.  
Passing options works differently than with normal Cucumber a command line might look like:

`bundle exec parallel_cucumber -- -p should_work -p parallel -- features` 

Note the double dashes, before and after our cucumber options.  Also note that we must specify the features folder in this case.

With the exception of the parallel_run batch file, you can run specific tests by passing the filename to Cucumber.  
When specifying feature files on the commandline you can include the line number of a specific scenario to run by including a colan and a line number like so:
`bundle exec cucumber features/foo.feature:5`  This tells Cucumber to only run the scenario found at line 5 of `foo.feature`.

Multiple features can be passed on the command line.

Cucumber will still apply tag selection to the passed files.  So if you tell it to run `foo.feature` with `-p should_work` any tests tagged `@wip` will still be excluded, even if that means no scenarios are actually run.
 
Running just `bundle exec cucumber` with no options at all will result in the entire suite being run against the test server using chrome.  

## Cucumber profiles

Cucumber profiles provide us a shorthand way to specify command line options to Cucumber, including setting environment variables.


The table below lists the various profiles available.  

| Type             | Profile        | Notes                                                                                                                                                                |
|------------------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   __Browsers__   |                |                                                                                                                                                                      |
|                  | chrome         | Sets BROWSER_BRAND to chrome.  This is the default if BROWSER_BRAND is not set.                                                                                      |
|                  | edge           | Sets BROWSER_BRAND to edge                                                                                                                                           |
|                  | firefox        | Sets BROWSER_BRAND to firefox                                                                                                                                        |
|                  | headless       | Enables headless (no visible browser) mode for chrome.                                                                                                               |
|                  | kb             | Sets KEEP_BROWSER to true.  The same browser will be used instead of creating a new one for each scenario.  (Speeds up test runs at the risk of cross contamination) |
| __Environments__ |                |                                                                                                                                                                      |
|                  | dev            | Uses neptune for the app server and proteus for the API server                                                                                                       |
|                  | test           | Uses pluto for the app server and styx for the API server                                                                                                            |
|                  | local          | Uses localhost for both the app server and API server.                                                                                                               |
| __Slicing__      |                |                                                                                                                                                                      |
|                  | nowip          | Do not run things tagged with @wip                                                                                                                                   |
|                  | no_known_issue | Do not run things tagged with @known_issue                                                                                                                           |
|                  | known_issue    | Run __only__ things tagged with @known_issue (So you can see if they're fixed)                                                                                       |
|                  | should_work    | Combines nowip and no_known_issue.  This is set by default if you use the linear_run batch file in the scripts folder                                                |
| __Browser Size__ |                |                                                                                                                                                                      |
|                  | desktop        | Sets BROWSER_RESOLUTION to 1900x900.                                                                                                                                 |
|                  | bootstraplg    | Sets BROWSER_RESOLUTION to 1200x900                                                                                                                                  |
|                  | bootstrapmd    | Sets BROWSER_RESOLUTION to 993x900                                                                                                                                   |
|                  | bootstrapsm    | Sets BROWSER_RESOLUTION to 769x900                                                                                                                                   |
|                  | bootstrapxs    | Sets BROWSER_RESOLUTION to 767x900                                                                                                                                   |
| __Run Type__     |                |                                                                                                                                                                      |
|                  | parallel       | Run the tests in parallel, one test process per CPU in the machine. Writes out results as json files.                                                                |
|                  | ci             | Run tests tagged as @ci, output both json and html results.                                                                                                          |
|                  | parallel_ci    | Combines parallel and ci profiles.                                                                                                                                   |

## Environment variables
The runtime behavior of the suite can be controlled with a number of environment variables. 
Many are optional, the ones that are not have default values that make sense for running the suite for QA.
Many of these variables can be set via profiles on the Cucumber command line, see the section on profiles for more details.

Note: Any path variables should use forward slashes in place of backslashes on all platforms.  Any path that starts with ./ is relative to the project root.

|       Type       | Variable           | Values                              | Default       | Notes                                                                                    |
|:----------------:|--------------------|-------------------------------------|---------------|------------------------------------------------------------------------------------------|
|     __paths__    |                    |                                     |               |                                                                                          |
|                  | DOWNLOAD_DIR       | A valid path                        | ./downloads   | Where to place downloaded files                                                          |
|                  | FIXTURE_ROOT       | A valid path                        | ./fixtures    | Where to find fixture files                                                              |
|                  | REPORT_DIR         | A valid path                        | ./reports     | Where to store test results                                                              |
|                  | SCREENSHOT_DIR     | A valid path                        | ./screenshots | Where to store screenshots of the page when a failure occurs                             |
| __environments__ |                    |                                     |               |                                                                                          |
|                  | TEST_ENV           | test, dev                           | test          | Which environment should the tests be run in.  Controls URLs and fixture loading         |
|                  | BASE_URL           | A URL                               | From TEST_ENV | The URL of the product.  If not provided a host name will be looked up based on TEST_ENV |
|   __browsers__   |                    |                                     |               |                                                                                          |
|                  | KEEP_BROWSER       | true, false                         | true          | Should we reuse the same browser, or create a new one for each scenario.                 |
|                  | BROWSER_TYPE       | local, sauce, selenium_hub          | local         | Should we use a local browser or a remote browser                                        |
|                  | BROWSER_BRAND      | chrome, firefox, edge, safari       | chrome        | What type of browser to use.                                                             |
|                  | SIZE_BROWSER       | true, false                         | false         | Should we resize the browser?                                                            |
|                  | HEADLESS           | true, false                         | false         | Should the browse run in headless mode?                                                  |
|                  | MOVE_BROSWER       | true, false                         | false         | Should we move the browser?                                                              |
|                  | BROWSER_RESOLUTION | NxN                                 | 1900x900      | What size should the browser be?                                                         |
|                  | BROWSER_X          | a number                            | 0             | Where should the left side of the browser be?                                            |
|                  | BROWSER_Y          | a number                            | 0             | Where should the top of the browser be?                                                  |
|                  | SAUCE_URL          | a url                               |               | The URL to use for connecting to Sauce                                                   |
|                  | SAUCE_PLATFORM     | See https://saucelabs.com/platforms |               | What OS to use when running under Sauce                                                  |
|                  | SELENIUM_HUB_HOST  | A valid hostname                    |               | The host your selenium hub resides on                                                    |
|                  | SELENIUM_HUB_PORT  | A number                            |               | The port your selenium hub listens on                                                    |
|                  | SELENIUM_HUB_URL   | A URL                               |               | Set the full Selenium Hub URL in one go.                                                 |
|     __Misc__     |                    |                                     |               |                                                                                          |
|                  | CUKE_DEBUG         | true, false                         | false         | Sets debug mode, causing the suite to open a debugger when an error occurs.              |
|                  | CUKE_STEP          | true, false                         | false         | If true, the suite will pause after each step until you hit enter.                       |

