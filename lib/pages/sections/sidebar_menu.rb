# frozen_string_literal: true

class SidebarMenuItem < EDSL::PageObject::Section
  label(:option_text, index: 0)
  i(:status_bad, class: 'status-bad')
  i(:status_good, class: 'status-ok')

  def status
    return :good if status_good?
    return :bad if status_bad?

    :none
  end

  def text
    option_text? ? option_text : super
  end
end

class SidebarMenu < EDSL::PageObject::Section
  sections(:options, SidebarMenuItem, class: 'list-group', how: :ul, item: { class: 'list-group-item', how: :lis })

  def populate_with(value)
    select_option(value)
  end

  def select_option(opt)
    parent_container.raise_page_errors "Attempting to access sidebar menu option: #{opt}"
    options.find { |o| o.text.strip.casecmp(opt).zero? }.click
    wait_for_ajax
    parent_container.raise_page_errors "After clicking sidebar menu option: #{opt}"
  end
end
