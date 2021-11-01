# frozen_string_literal: true

WFA_HOOKS ||= CptHook.define_hooks do
  after(:set).call(:wait_for_ajax)
  after(:click).call(:wait_for_ajax)
  after(:click!).call(:wait_for_ajax)
  after(:select).call(:wait_for_ajax)
end

TEXT_WAIT_HOOKS ||= CptHook.define_hooks do
  before(:text).call(:wait_for_ajax)
  after(:text).call(:wait_for_ajax)
end

PAGE_ERROR_HOOKS ||= CptHook.define_hooks do
  after(:set).call(:raise_page_errors)
  after(:click).call(:raise_page_errors)
  after(:click!).call(:raise_page_errors)
end

PANEL_ERROR_HOOKS ||= CptHook.define_hooks do
  before(:set).call(:raise_page_errors).using(:parent_container)
  before(:click).call(:raise_page_errors).using(:parent_container)
  before(:click!).call(:raise_page_errors).using(:parent_container)
  after(:set).call(:wait_for_ajax).call(:raise_page_errors).using(:parent_container)
  after(:click).call(:wait_for_ajax).call(:raise_page_errors).using(:parent_container)
  after(:click!).call(:wait_for_ajax).call(:raise_page_errors).using(:parent_container)
end
