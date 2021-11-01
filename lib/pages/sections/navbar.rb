# frozen_string_literal: true

class Navbar < BaseSection

  # DDL  I commented this code out since we have no top nabar.


  # ul(:navbar_nav, xpath: './/div[@id="cmi-default-header"]/ul')
  # text_field(:search_term, id: 'searchInput')
  # button(:search, text: 'GO')
  # button(:navbar_toggle, class: 'navbar-toggle')
  # link(:advanced_search, text: 'Advanced Search')
  #
  # def navigate_advanced
  #   ensure_nav_visible
  #   advanced_search
  # end
  #
  # def navigate_to(option)
  #   menu_item = find_option(option)
  #   raise "Could not find a navbar item matching '#{option}'" unless menu_item
  #
  #   leave_page_using(-> { menu_item.link.click })
  # end
  #
  # def find_option(option)
  #   ensure_nav_visible
  #   navbar_nav.list_items.find { |item| item.text.downcase.snakecase == option.to_s.downcase.snakecase }
  #
  # end
  #
  # def search_for(term)
  #   ensure_nav_visible
  #   self.search_term = term
  #   leave_page_using(:search)
  # end
  #
  # def ensure_nav_visible
  #   navbar_toggle if navbar_toggle? && !search?
  # end
end
