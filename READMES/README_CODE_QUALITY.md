# @markup markdown
# @title Code Quality

# Central Automation Code Quality Guidelines
 
 
## Introduction

In order to provide timely, meaningful feedback it is imperative that any automation suite provide accurate information.  Tests that are "flakey" and fail for reasons other than an assertion provide negative value. Not only have we spent resources to develop these tests, but we must continue to devote resources to root cause analysis.

When the system under test has an issue, automation is there to catch it.  When automation has issues there is no safety net.  It is imperative to take steps to protect ourselves from mistakes wherever possible.

## Code Style/Formatting
All code should follow the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide/blob/master/README.md).  By adhering to this guide we ensure that any new developer can easily follow the code and ramp-up much faster than when thrown into a mishmash of styles. 

Ensure that code is indented with two spaces, not 4, not tabs.  Your editor should have a setting to replace tabs with a number of spaces.

Ensure that all files use Unix style line endings.  On Windows you may want to let git provide you a safety net by issuing the following command at the command prompt: git config --global core.autocrlf true

RubyMine has built in support for the style guide and will flag code that doesn't comply and offers automatic fixes for many errors.

## Step definitions
* Stepdefs should be no longer than 5 lines of code.  More than that is an indicator you're including too much logic in your step.
* NEVER call a step from another step. If you find yourself "needing" to do so, that's another indicator you're including too much logic in your steps.
* Complex logic should be encapsulated within the PageObject or route not your pages.
* Stepdefs should not contain Watir calls.  Only the PageObject should manipulate the DOM in most cases.



## Code quality tools

The Central framework leverages code analysis tools to ensure a minimum level of quality before committing / code review.

### Rubocop

This tool enforces compliance with the Ruby Style Guide as well as identifying code that is too complex to be easily maintainable.  Documentation is available at http://rubocop.readthedocs.io/en/latest/

Two key metrics that Rubocop tracks are Cyclomatic Complexity and ABC Size.  When Rubocop flags these in your code it's an indicator that a human being could easily become confused while working with that function and make a change that has unintended consequences.

The easiest way to keep these metrics down is to break code into more manageable chunks and make use of helper functions.  For example instead of:

```ruby
if (user.is_admin? == true || user.in_group('editors') || doc.owner == user) && (doc.read_only? == false && doc.archived? == false)
```

You could break the conditionals out into helper functions:

```ruby
if user_can_edit_doc(user, doc) && doc_is editable(doc)
```

This makes the intent of the code clear immediately without introducing cognitive load on the reader.   If they need to dive deeper, they can inspect the code for the helper functions.
