@echo off
set env=test

echo "Starting Cucumber Suite"

del reports\*-%env%-results*.json
del reports\merged_results-*-%env%-*.json
del screenshots\%env%*.png

set mydate=%date:~10,4%%date:~4,2%%date:~7,2%
set mytime=%time:~0,2%%time:~3,2%
set mytimestamp=%mydate%%mytime%
echo %mytimestamp%

set merged_file="reports/merged_results-%mytimestamp%-%env%-ManualTrigger.json"

call bundle exec ruby script\post_deploy_runner_tfs.rb --env="%env%" --cuke="-p %env%" --changeset="ManualTrigger" --timestamp=%mytimestamp%
call bundle exec ruby script\merge_json.rb "reports/*-%env%-results\*.json" "%merged_file%"

echo "Completed Cucumber Suite in %env%"
echo "---------------------------------"

