@echo off
call bundle install
call bundle exec parallel_cucumber -n 8 --group-by scenarios -- -p should_work %* -p parallel  -- features/personal_auto

