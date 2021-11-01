# frozen_string_literal: true

class BasePanel < EDSL::PageObject::Section
  link(:modify_button, data_toggle: 'modal', hooks: PANEL_ERROR_HOOKS)
  div(:header, data_toggle: 'collapse')

  def title
    header_element.text.strip
  end

  def collapse
    header_element.click unless collapsed?
  end

  def expand
    header_element.click unless expanded?
  end

  def collapsed?
    header_element.attribute_value('aria-expanded') == 'false'
  end

  def expanded?
    header_element.attribute_value('aria-expanded') == 'true'
  end

  def modify
    scroll.to
    modify_button_element.click!
    parent_container.wait_for_modal_or_error
  end
end
