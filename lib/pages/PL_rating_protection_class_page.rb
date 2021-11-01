class PLRatingProtectionClassPage < BasePage
  #page_url "https://ratinguat.vertafore.com/UserInterface/Main/ClientEdit.aspx"
  text_field(:ok_button, xpath: './/div[@class="white-popup-inline popup-protclasslu"]//input[@id="btnOK"]')
  # link(:select_community, id: 'dgList_ctl03_Select')


end