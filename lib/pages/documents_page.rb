# frozen_string_literal: true


class DocumentsTableRow < BaseSection

  checkbox(:documents_checkbox, index: 0)
  td(:heading, index: 0)
  td(:document_name, index: 1)
  td(:document_status, index: 2)
  td(:document_actions, index: 3)
  button(:three_dots_action)
  link(:view_document, xpath: '//span[text() = "View"]/..', default_method: :click!)
end

class DocumentsPage < PolicyManagementPage
  page_url "#{Nenv.base_url}/PolicyAdminWeb/documents"

  def displayed?
    browser.url.include?('PolicyAdminWeb/documents')
  end

  # ------ Everything below this line is unverified ------------------------------------- #
  #


  # span(:client_name, name: 'ClientName')
  # span(:client_address, name: 'ClientAddress')
  li(:client_name, xpath: '//ul[@class="client-details"]//li', index: 0)
  li(:client_address, xpath: '//ul[@class="client-details"]//li', index: 1)
  button(:show_multiple_upload, xpath: '//*[@label = "Show Multiple Upload"]')
  button(:show_single_upload, xpath: '//*[@label = "Show Single Upload"]')
  button(:create_pdf, text: 'Create PDF')
  button(:manage_text_and_e_options, xpath: '//*[@label = "Manage Text & E-Options"]')
  label(:number_of_documents_selected, class: 'documentCheckBoxesSelected')
  text_field(:search, placeholder: 'Search...')
  checkbox(:all_documents_checkbox, name: 'chkAllItem')
  #link(:add_other_document, text: 'Add Other Document', hooks: WFA_HOOKS)
  button(:add_other_document, xpath: '//*[@label = "Upload File"]/button')
  link(:view, xpath: '//span[text() = "View"]/..')
  #data_grid(:documents_list, DocumentsTableRow, xpath: '//*[@id="grdViewDocuments"]//table', item: { xpath: './tbody//tr'})
  header_separated_data_grid(:docs_list, DocumentsTableRow, id: 'grdViewDocuments')
  #//app-documents/app-view-documents/p-table/

  section(:documents_forward_modal, DocumentsForwardModal, xpath: '//div[@id="divModalContent" and .//input[@value = "DocumentsForwardModal"]]')
  section(:other_documents_modal, OtherDocumentsModal, xpath: '//div[contains(@class,"modal") and .//span[contains(text(),"Other Documents")]]')

  section(:documents_section, DocumentsSection, xpath: '//div[@id= "bodyContainer"]/..')

  tab_strip(:tabs, id: 'customTab')

  def check_all(grid)
    send("#{grid}").items.each { |check| check.checkbox.set }
  end

  def url_match(string, url)
    url.include?(string)
  end

  # This is checking for a new window - not sure if this is the best
  # way to accomplish this.
  def wait_for_pdf_window(string)
    Timeout.timeout(Nenv.browser_timeout) do
      loading = true
      while loading
        check = url_match(string, RouteHelper.browser.windows.last.use.url)
        loading = false if check
        sleep(1)
      end
      return true
    end
  rescue Timeout::Error => e
    raise "Timeout waiting for window to load - #{e}"
    exit
  end
end
