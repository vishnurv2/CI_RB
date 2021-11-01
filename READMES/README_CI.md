# Continuous Integration

A subset of the full suite has been tagged to run as part of the CI system.  These tests hit major areas of functionality to catch any major issues quickly.  Should one of these tests fail, the build that triggered the test run will also fail.

## How it works

After a triggered build has been compiled, the resulting binaries are deployed to a machine reserved specifically for this process.  Once deployed, the build process will execute a powershell script remotely on the CI test server to run the tests. When the test run completes, it will return a pass/fail status to the build process and either pass or fail the build depending on the outcome.

Results of these runs are posted to the reporting engine (http://vsqvwdocker01:8080/) with the name "CI Run".  Should a build fail, the results from most recent CI run should be examined for errors.  In the absence of failures, normal deploy processes are in effect.