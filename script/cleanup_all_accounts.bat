@echo off
call script\cleanup_accounts_dev.bat > ..\..\accounts\logs\delete_output_dev.log
call script\cleanup_accounts_test.bat > ..\..\accounts\logs\delete_output_test.log
call script\cleanup_accounts_uat.bat > ..\..\accounts\logs\delete_output_uat.log