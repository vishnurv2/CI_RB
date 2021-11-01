Feature: PAT - Legacy XML comparator

  @fixture_intigration_auto_policy_sig_combined_none_pdf_validation_4
  Scenario: SC_04_8040929_Eff_10/30/20 Verify contents of Policy Declarations And Forms document for Auto-Signature
    Given I have created a new "auto" policy
    And I fully issue the policy
    And I gather account and policy numbers for "IN - Summit Auto" for fully issued policy
    Then I saved the "PolicyDeclarationsAndForms" pdf
    Then I am saving the XML

  @no_browser
  Scenario: Compare 2 XML'S
    Given I load "sample.xml" as first xml
    And I load "test.xml" as second xml
    Then I compare the xmls and generate the report

  @no_browser
  Scenario: Comparison of 2 XML files
    Given I load "sample.xml" as first xml
    And I load "test.xml" as second xml
    Then I compare the xmls and generate the report
    And I launch command prompt and compare the results
    And I write the difference report

  @no_browser
  Scenario: Comparison of 2 PDF files
    Given I load "sample.pdf" as first xml
    And I load "test.pdf" as second xml
    Then I compare the pdfs and generate the report
    And I launch command prompt and compare the results
    And I write the difference report
