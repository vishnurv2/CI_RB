
#class ScheduledPropertyItemRow < ::BaseSection
  #table heading

  #end

class ScheduledPropertyClassesPanel < BasePanel
  button(:modify)
  #data_grid(:items, ScheduledPropertyItemRow)

  #table heading
  th(:category_heading, xpath: './/th[contains(., "Category")]')
  th(:agreed_amount_heading, xpath: './/th[contains(., "Agreed Amount ")]')
  th(:agreed_deductible_heading, xpath: './/th[contains(., "Agreed Deductible ")]')
  th(:blanket_amount_heading, xpath: './/th[contains(., "Blanket Amount ")]')
  th(:blanket_deductible_heading, xpath: './/th[contains(., "Blanket Deductible ")]')
  th(:blanket_per_item_heading, xpath: './/th[contains(., "Blanket Per Item ")]')

  #table data
  td(:category, xpath: './/td[contains(@data-label, "Category")]')
  td(:agreed_amount, xpath: './/td[contains(@data-label, "Agreed Amount")]')
  td(:agreed_deductible, xpath: './/td[contains(@data-label, "Agreed Deductible")]')
  td(:blanket_amount, xpath: './/td[contains(@data-label, "Blanket Amount")]')
  td(:blanket_deductible, xpath: './/td[contains(@data-label, "Blanket Deductible")]')
  td(:blanket_per_item, xpath: './/td[contains(@data-label, "Blanket Per Item")]')
  td(:total_vehicle, xpath: './/td[contains(@data-label, "Total Vehicle")]')
  td(:deductible, xpath: './/td[contains(@data-label, "Deductible")]')
end