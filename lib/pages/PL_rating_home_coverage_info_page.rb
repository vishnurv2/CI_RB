class PLRatingHomeCoverageInfo < BasePage
  #page_url "https://ratinguat.vertafore.com/UserInterface/USA/PA/GeneralEdit.aspx?FromCoSelect=True"

  text_field(:dwelling_coverage, id: 'rniDwellingCoverage')




  link(:carrier_link, xpath: '//td[@class="submit"]/img')
  link(:spinner, xpath: '//i[contains(@class,"fa fa-spinner")]')
  span(:premium, xpath: '//td[@class="highlightSubmit"]/span')
end