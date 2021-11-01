# frozen_string_literal: true

# Module containing custom elements for Central insurance
module CentralElements

  # A class to represent a data table wit pagination.
  class Accordion < ::EDSL::ElementContainer

    def wait_for_ajax
      parent_container.wait_for_ajax
    end

    def item_elements # this function has been verified for angular
      elements(xpath: './/p-accordiontab')
    end

    def items # this function has been verified for angular
      item_elements.map { |r| @item_class.new(r, self) }
    end

    def find_by(what, value)
      items.find { |app| app.send(what).strip == value.strip }
    end

    def headers
      elements(xpath: './/p-accordiontab').div
    end
    # all paging will have to be verified, not sure if there will be paging once we move to Angular

    def initialize(item_class, element, container, item_how)
      super(element, container)
      @item_class = item_class
      @item_how = item_how
    end
  end

  EDSL.extend_dsl do # this function has been verified for angular
    def accordion(name, item_class, opts = {})
      opts = { xpath: './/*[name(parent::*)="p-accordion" or local-name()="p-accordion"]/div', item: { xpath: './/p-accordiontab'}, default_method: :items }.merge(opts)
      item_how = opts.delete(:item) { |_el| { xpath: './/p-accordiontab' } }
      element(name, { how: :element, wrapper_fn: ->(element, container) { Accordion.new(item_class, element, container, item_how) } }.merge(opts))
    end
  end
end