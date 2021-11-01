# frozen_string_literal: true

## A module to help with integration tasks.

module IntegrationHelper

  def save_link_as(text, bow)
    bow.browser.link({xpath: ".//a[contains(text(), '#{text}')]"}).when_present.right_click
  end

end

include IntegrationHelper # This line allow auto include when the user require the gem
