# frozen_string_literal: true

class ProductToIssueRow < BaseSection
  link(:quote)
  span(:product, name: 'ProductNameText')
  link(:product_link, class: 'ProductNameText')
  span(:effective_date, name: 'EffectiveDateText')
  span(:exp_date, name: 'ExpirationDateText')
  span(:premium, name: 'PremiumText')
  span(:new_paper_distribution, name: 'NewPaperDistToggleButton')
  span(:renew_paper_distribution, name: 'RenewPaperDistToggleButton')
  checkbox(:issue, id: /IssueCheckBox/)
  td(:issue_td, data_label: 'Issue')

  def checkbox_enabled?
    return !checkbox_disabled?
  end

  def checkbox_disabled?
    return issue_td_element.classes.include? 'cmi-disabled'
  end
end

class PolicyDistributionOptionsPanel < BaseSection
  link(:modify, id: 'lnkModifyAutoGenInfo')
  link(:modify_policy_distribution, id: 'lnkModifyPolicyDistribution')
end

class PolicyIssuancePage < PolicyManagementPage
  section(:policy_distribution_options_panel, PolicyDistributionOptionsPanel, id: 'PolicyDistributionOptionsPartial')
  span(:client_name, name: 'ClientName')
  span(:client_address, name: 'ClientAddress')
  sections(:products_to_issue, ProductToIssueRow, how: :tbody, index: 0, item: { how: :trs, role: 'row' })
  span(:total_premium, name: 'TotalPremiumText')
  link(:issue_policies, text: /Issue Policies/, hooks: WFA_HOOKS)

  def issue_policy
    issue_policies
    issue_policies_modal.submit
    #     OLD WAY using save and continue
    #     policy_distribution_options_panel.modify
    #     e_policy_modal.submit
    #     policy_distribution_modal.submit
    #     issue_policies_modal.submit
  end

  def fully_issue_policy
    Watir::Wait.until(timeout: 30) { left_nav.issue_policy? }
    left_nav.issue_policy_element.scroll.to
    left_nav.issue_policy
    wait_for_ajax
    premium = issue_policies_modal.total_premium_amount
    msg = "Timed out waiting on saving the SELECT PRODUCT TO ISSUE MODAL!\n\n"
    msg += "Automation caught the following alert message text: \n#{Toaster.errors.uniq.join("\n\n")}\n\n"
    Watir::Wait.until(timeout: 40, message: msg) { issue_policies_modal? }

    # List of policies to issue, check all
    issue_policies_modal.check_all_products=true
    issue_policies_modal.next
    wait_for_ajax

    # Policy Distribution
    policy_distribution_modal.next if policy_distribution_modal?

    # issue policy ( confirmation )
    issue_policies_modal.submit if issue_policies_modal?

    wait_for_ajax
    # Use the link to go to Account Summary
    policies_issued_modal.to_account_summary

    premium # return premium
  end

  def click_issue_policy
    Watir::Wait.until(timeout: 30) { left_nav.issue_policy? }
    left_nav.issue_policy
    wait_for_ajax
    premium = issue_policies_modal.total_premium_amount
    msg = "Timed out waiting on saving the SELECT PRODUCT TO ISSUE MODAL!\n\n"
    msg += "Automation caught the following alert message text: \n#{Toaster.errors.uniq.join("\n\n")}\n\n"
    Watir::Wait.until(timeout: 40, message: msg) { issue_policies_modal? }
    premium
  end

  def answer_e_policy
    policy_distribution_options_panel.modify
    e_policy_modal.email = 'newemail@newemail.com'
    e_policy_modal.save_and_close_details
  end

  def issue_policy_no_e_policy
    policy_distribution_options_panel.modify
    e_policy_modal.e_policy='No'
    e_policy_modal.submit
    policy_distribution_modal.submit
    issue_policies_modal.submit
  end

  def displayed?
    browser.url.include?('PolicyManagement/Issuance/Issuance')
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    STDOUT.puts
    # rubocop:enable Lint/Debugger
  end
end
