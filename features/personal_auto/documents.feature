@auto @account_management
Feature: Documents page

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T188
  Scenario: Account has active policy documents in Policy View
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I navigate to "Documents" using the left nav
    Then I should see documents listed in Policy Documents section

  @regression @delete_when_done @fixture_auto_policy_autoplus_combined_none_old_driver @TestCaseKey=PAT-T190
  Scenario: Application PDF Link Loads Application PDF
    Given I have created a new "Auto" policy
    And I begin issuance
    And I navigate to "Documents" using the left nav
    When I click the PDF Icon for the Application document
    Then I should see a new tab

  @delete_when_done @fixture_upload_other_document @TestCaseKey=PAT-T191
  Scenario: "Other" documents can be uploaded
    Given I have created a new "Auto" policy
    And I navigate to "Documents" using the left nav
    When I upload the "sample_pdf_1" as an other document
    Then the other document should be displayed with a status of "Uploaded"

  @regression @delete_when_done @fixture_auto_policy_autoplus_combined_none_old_driver @TestCaseKey=PAT-T189
  Scenario: Documents are listed
    Given I have created a new "Auto" policy
    And I begin issuance
    When I navigate to "Documents" using the left nav
    Then I should see documents listed in both sections of the documents page

  @delete_when_done @fixture_auto_policy_autoplus_combined_none @TestCaseKey=PAT-T187
  Scenario: Auto Application and Binder documents should be present after issuance
    Given I have created a new "Auto" policy
    And I navigate to "Quote Management" using the left nav
    When I navigate to "Documents" using the left nav
    And I should not see "Binder" document in "Retain in Agency" section
    And I should not see "Auto Application" document in "Retain in Agency" section
    Then I begin issuance
    When I navigate to "Documents" using the left nav
    And I should see "Binder" document in "Retain in Agency" section
    And I should see "Application" document in "Retain in Agency" section

#    bug PAT-10303
  @delete_when_done @fixture_auto_policy_autoplus_combined_none_uim @PAT-4527 @known_issue @TestCaseKey=PAT-T3670
  Scenario: Auto Application and Binder documents not be present after fully issue
    Given I have created a new "Auto" policy
    Then I begin issuance
    When I navigate to "Documents" using the left nav
    Then I should see "UMUIMSelectionForm" document in "Forward To Central" section
    And I should see "Binder" document in "Retain in Agency" section
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    When I finish issuing the policy
    When I navigate to "Documents" using the left nav
    And I should not see "Binder" document in "Retain in Agency" section


  ## NOt converted below ##
  ## This works if you run -desktop, however headless doesnt seem to recognize the new tab?
  # I think instead of opening in new tab, its downloading?
  @regression @delete_when_done @fixture_auto_policy_autoplus_combined_none_old_driver @PAT194 @wip @TestCaseKey=PAT-T3671
  Scenario: Documents can be combined
    Given I have created a new "Auto" policy
    Then I navigate to "Documents" using the left nav
    When I check all of the "Forms to Forward" documents
    And I check all of the "Forms to Retain" documents
    Then The documents should have merged into a new window

# This test is for documents_forward_modal which is currently not present on documents page.
  @delete_when_done @fixture_auto_policy_autoplus_combined_none_old_driver @wip @TestCaseKey=PAT-T3672
  Scenario: Documents can be uploaded
    Given I have created a new "Auto" policy
    And I navigate to "Documents" using the left nav
    When I upload the "sample_pdf_1" as the "EFT Authorization Form"
    Then the "EFT Authorization Form" should show as "Uploaded"