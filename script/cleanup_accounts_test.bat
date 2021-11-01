@echo off
set env=test
call bundle exec cucumber -p headless -p %env% features/clean_accounts.feature %*
del ..\..\accounts\*.%env%
