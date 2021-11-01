# frozen_string_literal: true

class UnderwritingReferralsAlertSection < BaseSection

  # ------ Everything below this line is unverified ------------------------------------- #
  #
  div(:uw_ref_accordion, id: 'underwriting-referrals-accordion')
  css_state(:uw_ref_accordion, open: 'in', animating: 'collapsing', closed: { not: 'in' })
  div(:toggle_accordion, data_target: '#underwriting-referrals-accordion', default_method: :click)
  div(:panel, class: 'underwriting-referrals-panel')
  css_state(:panel, green: 'status-ok', red: { not: 'status-ok' })

  def red?
    panel_red?
  end

  def green?
    panel_green?
  end

  def open?
    uw_ref_accordion_open?
  end

  def closed?
    uw_ref_accordion_closed?
  end

  def open
    toggle_accordion unless open?
    sleep 1
  end

  def close
    toggle_accordion unless closed?
    sleep 1
  end

  def alerts
    open
    spans(class: 'text-tab').map(&:text)
  end
end

class QuoteOptionsPage < PolicyManagementPage

  # ------ Everything below this line is unverified ------------------------------------- #

  sections(:quote_option_panels, QuoteOptionPanel, id: 'divOptionsAndProductsHeader', item: { id: /quoteOption/ })
  link(:apply_quote, text: 'Apply Selected Quote', default_method: :click!)

  section(:uw_ref_section, UnderwritingReferralsAlertSection, id: 'divUnderwritingReferrals')

  def displayed?
    browser.url.include?('PolicyManagement/Quote/Options?accountId=')
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end
end
