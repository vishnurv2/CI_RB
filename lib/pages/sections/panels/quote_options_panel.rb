# frozen_string_literal: true

class QOPVehicleSection < BaseSection
  span(:vehicle_name, id: /vehicle/)
  span(:liability, id: /liability/)
  span(:collision, id: /collision/)
  span(:other_than_collision, id: /otherCollision/)
  select(:liability_dropdown, id: /liability/)
  select(:collision_dropdown, id: /collision/)
  select(:other_than_collision_dropdown, id: /otherCollision/)

  def coverage_names
    divs(class: 'control-label')[0..-1].map(&:text)
  end

  def coverages
    divs(class: 'quote-option-row')[1..-1].map(&:text).map { |c| c.include?("\n") ? c : "#{c}\nVALUE MISSING" }.map { |c| c.split("\n") }.to_h
  end
end

class QOPDriverDiscount < BaseSection
  label(:name)
  checkbox(:selected)

  def select
    selected.check
  end

  def unselect
    selected.clear
  end

  def toggle
    selected_element.send selected == true ? :clear : :check
  end
end

class QOPDriverDiscountSection < BaseSection
  span(:driver_name, name: 'DriverName')

  def discount_divs
    @discount_divs = div(class: 'form-control-static').divs(class: 'row')
  end

  def discount(name)
    CentralElements::CheckboxCMI.new(divs(class: 'checkbox').find { |d| d.label.text == name }, self)
  end

  def discounts
    discount_divs.map(&:text)
  end

  def applicable_discounts
    divs(class: 'checkbox').map { |d| d.label.text }
  end

  def selected_discounts
    divs(class: 'checkbox').select { |d| d.checkbox.checked? }.map { |d| d.label.text }
  end
end

class QuoteOptionPanel < BaseSection
  h4(:title, xpath: '//*[@name="quoteOptionHeader"]/div[1]/div[1]/h4')
  button(:select_option, name: 'quote-select', hooks: WFA_HOOKS, default_method: :click!)
  button(:rate_custom_option, name: 'RateCustomOption', hooks: WFA_HOOKS, default_method: :click!)
  span(:liability_limit, name: 'AutoPolicyCoverageLiabilityLimit')
  span(:enhanced_coverage, name: 'ProductEnhancedCoverage')
  span(:product_premium, name: 'ProductPremiumAmount')
  span(:product_full_pay_premium, name: 'ProductFullPayPremiumAmount')
  div(:quote_options_ind, xpath: './/div[contains(@class, "quote-accordion")]/div[contains(@class, "panel-collapse")][1]')
  css_state(:quote_options_ind, open: 'in', animating: 'collapsing', closed: {not: 'in'})
  div(:quote_options_heading, class: 'panel-heading', default_method: :click, hooks: WFA_HOOKS)
  span(:product_name, name: 'FormattedProductName')

  select(:enhanced_auto_coverage_select, id: /SelectEnhancedAutoCoverage_/)

  span(:product_liability_limit, name: 'AutoPolicyCoverageLiabilityLimit')

  select_list(:upgraded_liability_limit, id: /AutoPolicyCoverageSelectLiabilityLimit_/)

  span(:popular_auto_liability_limit, name: 'AutoPolicyCoverageLiabilityLimit')

  sections(:vehicles, QOPVehicleSection, xpath: '.', item: {id: /Vehicle_/})
  sections(:driver_discounts, QOPDriverDiscountSection, xpath: '.', item: {name: /divDriverDiscount/})

  %i[product_liability_limit enhanced_coverage].each do |which|
    define_method("#{which}_difference?") do
      _difference_highlighter?(which)
    end
  end

  def _difference_highlighter?(which)
    send("#{which}_element").classes.include?('difference-highlighter') || send("#{which}_element").parent.classes.include?('difference-highlighter')
  end

  def expand_quote_options
    return if quote_options_ind_open?

    quote_options_heading
    Watir::Wait.until(timeout: 2) { quote_options_ind_state == :open }
    sleep 0.25
  end

  def collapse_quote_options
    return if quote_options_ind_state == :closed

    quote_options_heading
    Watir::Wait.until(timeout: 2) { quote_options_ind_state == :closed }
    sleep 0.25
  end

  def selected?
    class_name.include?('quote-active')
  end
end
