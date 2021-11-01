@echo off
set env=dev

echo "Starting Cucumber Suite"

del reports\*-%env%-results*.json
del reports\merged_results-*-%env%-*.json
del screenshots\%env%*.png

set mydate=%date:~10,4%%date:~4,2%%date:~7,2%
set mytime=%time:~0,2%%time:~3,2%
set mytimestamp=%mydate%%mytime%
echo %mytimestamp%

set merged_file="reports/merged_results-%mytimestamp%-%env%-AccountApiCore.json"

call bundle exec ruby script\post_deploy_runner_api.rb --env="%env%" --cuke="-p account_api_dev" --changeset="AccountApiCore" --timestamp=%mytimestamp% --threads=1
call bundle exec ruby script\merge_json.rb "reports/*-%env%-results\*.json" "%merged_file%"

echo "Completed Cucumber Suite in %env%"
echo "---------------------------------"

