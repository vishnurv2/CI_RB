# frozen_string_literal: true

class LeftNavbar < BaseSection

  # ------ Almost everything is verified on this page - its marked if not. ------------------------------------- #
  #
  class LeftNavItem < ::EDSL::ElementContainer
    label(:text)
    i(:green_check_mark, class: 'status-ok')
    i(:red_exclamation_point, class: 'status-bad')

    def active?
      class_name.include? 'active'
    end

    def collapsable?
      !data_toggle.nil?
    end
  end

  ul(:list_group, class: ["nav", "flex-column", "sidebar-nav"])

  # button(:add_product, xpath: './/p-button[@id="addProduct"]/button')
  link(:quotes, id: 'PolicyQuoteMode')
  link(:policies, id: 'PolicyViewMode')
  button(:issue_policy, xpath: './/p-button[@id="issuePolicy"]/button')
  i(:bell_alert_icon_badge, id: 'alertIconBadge')
  span(:bell_icon, class: /fa-bell alert-icon/)
  button(:actions, xpath: './/p-button[@id="ddlActions"]/button')
  link(:new_quote, xpath: './/a[.//*[contains(text(), "New Product")]]')
  button(:add_product, xpath: './/button[@ptooltip="Add Product"]')
  link(:issues_to_resolve, xpath: './/a[contains(@class, "issues-to-resolve-anchor")]')
  span(:red_dot, class: /invalid-circle/)
  link(:open_policy_changes, xpath: './/span[contains(text(), "Open Policy Changes")]/parent::a')

  def navigate_to_first_product
    div(id: 'Quotes').li(xpath: './/li[.//a[contains(@href, "/PL/") and not(contains(@href,"quotes"))]]').link().click
    wait_for_ajax
  end

  def navigate_to(option)
    menu_item = find_option(option)
    raise "Could not find a left nav item matching '#{option}'" unless menu_item

    leave_page_using(-> { menu_item.link.click })
  end

  def click_menu_item(option)
    menu_item = find_option(option)
    raise "Could not find a left nav item matching '#{option}'" unless menu_item

    menu_item.link.click
  end

  def select_option(option)
    menu_item = find_option(option)
    raise "Could not find a left nav item matching '#{option}'" unless menu_item

    menu_item.link.click
  end

  # NOT verified
  def open_auto_summary(index = 0)
    links(href: /personal\/auto/)[index].click!
  end

  def menu_items
    lis.map { |i| LeftNavItem.new(i) }
  end

  ## Not working.  the wait for the 'aria-expanded' needs updated
  def expand_collapsed_menu_items
    cds = divs(class: 'collapse').reject { |d| d.class_name.include?('in') }
    cmis = menu_items.select { |mi| cds.any? { |cd| mi.data_target == "##{cd.id}" } }
    cmis.each do |cmi|
      cmi.click
      Watir::Wait.until { cmi.attribute_value('aria-expanded') == 'true' }
    end
  end

  def switch_modes
    if quotes_element.parent.attributes[:aria_selected] == 'false'
      quotes
    elsif policies_element.parent.attributes[:aria_selected] == 'false'
      policies
    end
  end

  def strip_labels(str)
    str.split(/\n/).first
  end

  def find_option(option)
    #item = menu_items.find { |item| strip_labels(item.link.text).downcase.snakecase == option.to_s.downcase.snakecase  if item.link.present? }
    item = menu_items.find { |item| strip_labels(item.link.text).downcase.snakecase.include? option.to_s.downcase.snakecase  if item.link.present? }
    return item unless item.nil?

    switch_modes
    menu_items.find { |item| item.link.text.downcase.snakecase == option.to_s.downcase.snakecase }
  end

  def find_option_containing(option)
    item = menu_items.find { |item| item.link.text.include? option.to_s }
    return item unless item.nil?
    switch_modes
    menu_items.find { |item| item.link.text.include? option.to_s }
  end

  def find_attached_option(option)
    item = menu_items.find { |item| item.spans(class: /attachedProductIndent/).find {|i|i.following_sibling.text.downcase.snakecase == option.to_s.downcase.snakecase} if item.span(class: /attachedProductIndent/).present? }
    return item unless item.nil?

    switch_modes
    menu_items.find { |item| item.spans(class: /attachedProductIndent/).find {|i|i.following_sibling.text.downcase.snakecase == option.to_s.downcase.snakecase} if item.span(class: /attachedProductIndent/).present? }
  end

  def navigate_to_attached_product(option)
    menu_item = find_attached_option(option)
    raise "Could not find a left nav item matching '#{option}'" unless menu_item

    leave_page_using(-> { menu_item.spans(class: /attachedProductIndent/).find {|i|i.following_sibling.text.downcase.snakecase == option.to_s.downcase.snakecase}.parent.click })
  end

end
