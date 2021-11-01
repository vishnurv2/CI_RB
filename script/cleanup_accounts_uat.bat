@echo off
set env=uat
call bundle exec cucumber -p headless -p %env% features/clean_accounts.feature %*
del ..\..\accounts\*.%env%
