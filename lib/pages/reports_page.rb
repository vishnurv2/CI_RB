# frozen_string_literal: true

class ReportsPage < PolicyManagementPage

  def displayed?
    browser.url.include?('PolicyAdminWeb/PL/reports')
  end

  # ------ Everything below this line is unverified ------------------------------------- #
  #------- Paste your verified items above this line so we know whats been fixed!!
  #
  #
  page_url "#{Nenv.base_url}/PolicyManagement/Reports/Summary"

  section(:clue_prefill_mvr_section, ReportsSection, xpath: '//div[@id= "bodyContainer"]/..')
  section(:insurance_score_section, InsuranceScoreSection, id: 'insuranceScore')
  section(:territory_section, TerritoryReportSection, id: 'divReportsSummaryTerritoryReport')

  section(:auto_clue_modal, ClueLossesModal, xpath: '//div[@id="divModalContent" and .//div/h4[contains(text(), "Report Results - CLUE")]]')
  #section(:report_results_modal, ReportResultsModal, xpath: '//div[@id="divModalContent"]/div[@id="divModalContent" and .//div/h4[contains(text(), "Reports Results")]]')
  section(:report_results_modal, ReportResultsModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Report Results")]]')
  section(:change_premium_modal, BaseModal, xpath: '//div[@id="divModalContent"]/div[@id="divModalContent" and .//div/h4[contains(text(), "Reports Results")]]')
  section(:auto_driver_modal, AutoDriverModal, xpath: '//div[@role="dialog" and .//span[contains(text(), "Drivers")]]')
  section(:territory_report_modal, TerritoryReportModal, xpath: '//div[contains(@class,"p-dynamic-dialog") and .//div/span[contains(text(), "Territory")]]')
  section(:inspection_order_modal, InspectionOrderModal, xpath: '//div[contains(@class,"p-dynamic-dialog") and .//div/span[contains(text(), "Inspection Order")]]')

  sections(:reports_sections, ReportsSection, xpath: '//app-reports//div', item: { xpath: './/p-tabpanel/div', how: :divs })
  link(:show_order_history, xpath: './/tbody[@class="p-datatable-tbody"]/tr[4]/td[4]/a')
  th(:inspection_type, xpath: './/th[contains(.,"Inspection Type")]')
  th(:supplements, xpath: './/th[contains(.,"Supplement")]')
  th(:ordered_date, xpath: './/th[contains(.,"Ordered Date")]')
  th(:received_date, xpath: './/th[contains(.,"Received Date")]')
  th(:status, xpath: './/th[contains(.,"Status")]')


  def open_and_save_report(report_type, reports_section)
    reports_section.find_report_by_type(report_type).edit
    wait_for_modal(auto_clue_modal)
    auto_clue_modal.save_and_continue
    wait_for_modal(auto_driver_modal)
  end

  def wait_for_modal(modal)
    Watir::Wait.until { modal.present? }
    wait_for_ajax
    raise_page_errors "waiting for modal #{modal.symbol} to appear"
  end

  def pry
    # rubocop:disable Lint/Debugger
    binding.pry
    # rubocop:enable Lint/Debugger
    puts 'line for pry'
  end

  def resolve_issues_to_resolve
    collapsed_row = clue_prefill_mvr_section.reports_grid.find { |i| i.chevron_right? }
    if !collapsed_row.nil?
      collapsed_row.chevron_right_element.click
    end
    order_reports_row = clue_prefill_mvr_section.reports_grid.find { |i| i.order_reports? || i.order_btn_disabled? }
    policy_name = clue_prefill_mvr_section.products_row.first.text
    if !order_reports_row.nil?
      if order_reports_row.order_reports_element.present?
        if !order_reports_row.order_btn_disabled?
          order_reports_row.order_reports
        end
      end
    end
    if order_reports_row.nil?
      if clue_prefill_mvr_section.order_reports_element.present?
        if !clue_prefill_mvr_section.order_reports_element.disabled?
          scroll.to :top
          clue_prefill_mvr_section.order_reports
        end
      end
    end
    sleep(2)
    wait_for_overlay_no_ajax_wait unless inspection_order_modal?
    if policy_name.include? 'Auto'
      Watir::Wait.until(timeout: 30) { report_results_modal? || auto_driver_modal? || premium_change_modal? || inspection_order_modal? }
    end
    2.times do
      if report_results_modal?
        sleep(2)
        wait_for_overlay_no_ajax_wait
        if report_results_modal.save_and_continue_element.present?
          wait_for_overlay_no_ajax_wait
          sleep(2)
          report_results_modal.save_and_continue
        else
          wait_for_overlay_no_ajax_wait
          report_results_modal.save_and_close if report_results_modal.save_and_close_element.present?
        end
        sleep(2)
        wait_for_overlay_no_ajax_wait
      end
    end
    if policy_name.include? 'Auto'
      Watir::Wait.until(timeout: 30) { report_results_modal? || auto_driver_modal? || premium_change_modal? || inspection_order_modal? }
    end
    sleep(2)
    wait_for_overlay_no_ajax_wait
    3.times do
      if auto_driver_modal?
        wait_for_overlay_no_ajax_wait
        auto_driver_modal.save_and_continue if auto_driver_modal.save_and_continue?
        sleep(2)
        wait_for_overlay_no_ajax_wait
      end
    end
    # if policy_name.include? 'Auto'
    #   Watir::Wait.until(timeout: 30) { report_results_modal? || auto_driver_modal? || premium_change_modal? || inspection_order_modal? }
    # end
    sleep(2)
    wait_for_overlay_no_ajax_wait
    4.times do
      sleep(2)
      wait_for_overlay_no_ajax_wait
      if premium_change_modal?
        wait_for_overlay_no_ajax_wait
        premium_change_modal.close
        wait_for_overlay_no_ajax_wait
        # wait_for_modal_to_close('premium_change_modal')
      end
    end
    sleep(2)
    wait_for_overlay_no_ajax_wait
    3.times do
      if auto_driver_modal?
        wait_for_overlay_no_ajax_wait
        auto_driver_modal.save_and_continue
        sleep(2)
        wait_for_overlay_no_ajax_wait
      end
    end
    sleep(2)
    wait_for_overlay_no_ajax_wait
    if inspection_order_modal?
      wait_for_overlay_no_ajax_wait
      inspection_order_modal.submit_order
      wait_for_overlay_no_ajax_wait
    end
    sleep(2)
    wait_for_overlay_no_ajax_wait
    if report_results_modal?
      wait_for_overlay_no_ajax_wait
      report_results_modal.save_and_close_btn_element.click if report_results_modal.save_and_close_btn_element.present?
      wait_for_overlay_no_ajax_wait
    end
    sleep(5)
    wait_for_overlay_no_ajax_wait
    4.times do
      sleep(2)
      wait_for_overlay_no_ajax_wait
      if premium_change_modal?
        wait_for_overlay_no_ajax_wait
        premium_change_modal.close
        wait_for_overlay_no_ajax_wait
        # wait_for_modal_to_close('premium_change_modal')
      end
    end
    sleep(2)
    wait_for_overlay_no_ajax_wait
    if report_results_modal.apply_to_quotes?
      wait_for_overlay_no_ajax_wait
      report_results_modal.apply_to_quotes
      Watir::Wait.while { report_results_modal.apply_to_quotes? }
      wait_for_overlay_no_ajax_wait
    end
    scroll.to :top
  end

  def resolve_issues_to_resolve_home
    collapsed_row = clue_prefill_mvr_section.reports_grid.find { |i| i.chevron_right? }
    if !collapsed_row.nil?
      collapsed_row.chevron_right_element.click
    end
    order_reports_row = clue_prefill_mvr_section.reports_grid.find { |i| i.order_reports? || i.order_btn_disabled? }
    if !order_reports_row.nil?
      if order_reports_row.order_reports_element.present?
        if !order_reports_row.order_btn_disabled?
          order_reports_row.order_reports
        end
      end
    end
    if order_reports_row.nil?
      if clue_prefill_mvr_section.order_reports_element.present?
        if !clue_prefill_mvr_section.order_reports_element.disabled?
          clue_prefill_mvr_section.order_reports
        end
      end
    end
    sleep(1)
    wait_for_overlay_no_ajax_wait
    inspection_order_modal.submit_order if inspection_order_modal?

    # Watir::Wait.until { report_results_modal? }
    wait_for_overlay_no_ajax_wait
    # Watir::Wait.until(timeout: 30) { report_results_modal? || auto_driver_modal? || premium_change_modal? || inspection_order_modal?}
    if report_results_modal?
      if report_results_modal.save_and_close_btn?
        sleep(1)
        wait_for_overlay_no_ajax_wait
        report_results_modal.save_and_close_btn
        sleep(2)
        Watir::Wait.while { report_results_modal.save_and_close_btn? }
        wait_for_overlay_no_ajax_wait
      end
      sleep(2)
      wait_for_overlay_no_ajax_wait
      if report_results_modal.apply_to_quotes?
        wait_for_overlay_no_ajax_wait
        report_results_modal.apply_to_quotes
        Watir::Wait.while { report_results_modal.apply_to_quotes? }
        wait_for_overlay_no_ajax_wait
      end
    end
    sleep(3)
    wait_for_processing_overlay_to_close
    # Watir::Wait.until(timeout: 30) { report_results_modal? || auto_driver_modal? || premium_change_modal? || inspection_order_modal?}
    if premium_change_modal?
      wait_for_overlay_no_ajax_wait
      premium_change_modal.close
      wait_for_modal_to_close('premium_change_modal')
    end
    if report_results_modal? && report_results_modal.save_and_close_btn?
      report_results_modal.save_and_close_btn
      Watir::Wait.while { report_results_modal? }
    end
    if premium_change_modal?
      wait_for_overlay_no_ajax_wait
      premium_change_modal.close
      wait_for_modal_to_close('premium_change_modal')
    end
  end

  def multiple_order_reports_button
    clue_prefill_mvr_section.expand_each_policy_reports
    i = 0
    clue_prefill_mvr_section.order_reports_rows.each do |row|
      count = clue_prefill_mvr_section.products_row.count
      policy_name = clue_prefill_mvr_section.products_row[i].text
      i = i + 1 unless i == count - 1
      if row.order_reports_element.present?
        if !row.order_btn_disabled?
          row.order_reports
          wait_for_overlay_no_ajax_wait unless inspection_order_modal?
          if policy_name.include? 'Auto'
            Watir::Wait.until(timeout: 30) { report_results_modal? || auto_driver_modal? || premium_change_modal? || inspection_order_modal? }
          end
          sleep(2)
          2.times do
            if report_results_modal?
              wait_for_overlay_no_ajax_wait
              if report_results_modal.save_and_continue_element.present?
                wait_for_overlay_no_ajax_wait
                report_results_modal.save_and_continue
              else
                wait_for_overlay_no_ajax_wait
                report_results_modal.save_and_close_btn_element.click
              end
              sleep(2)
              wait_for_overlay_no_ajax_wait
            end
          end
          if policy_name.include? 'Auto'
            Watir::Wait.until(timeout: 30) { report_results_modal? || auto_driver_modal? || premium_change_modal? || inspection_order_modal? }
          end
          sleep(2)
          wait_for_overlay_no_ajax_wait
          2.times do
            sleep(2)
            wait_for_overlay_no_ajax_wait
            if auto_driver_modal?
              wait_for_overlay_no_ajax_wait
              auto_driver_modal.save_and_continue if auto_driver_modal.save_and_continue?
              sleep(2)
              wait_for_overlay_no_ajax_wait
            end
          end
          # if policy_name.include? 'Auto'
          #   Watir::Wait.until(timeout: 30) { report_results_modal? || auto_driver_modal? || premium_change_modal? || inspection_order_modal? }
          # end
          sleep(2)
          wait_for_overlay_no_ajax_wait
          3.times do
            sleep(2)
            wait_for_overlay_no_ajax_wait
            if premium_change_modal?
              wait_for_overlay_no_ajax_wait
              premium_change_modal.close
              wait_for_overlay_no_ajax_wait
              # wait_for_modal_to_close('premium_change_modal')
            end
          end
          sleep(2)
          wait_for_overlay_no_ajax_wait
          if inspection_order_modal?
            wait_for_overlay_no_ajax_wait
            inspection_order_modal.submit_order
            wait_for_overlay_no_ajax_wait
          end
          sleep(2)
          wait_for_overlay_no_ajax_wait
          if report_results_modal?
            wait_for_overlay_no_ajax_wait
            if report_results_modal.save_and_continue_element.present?
              wait_for_overlay_no_ajax_wait
              report_results_modal.save_and_continue
            else
              wait_for_overlay_no_ajax_wait
              report_results_modal.save_and_close_btn_element.click
            end
            sleep(2)
            wait_for_overlay_no_ajax_wait
          end
          sleep(2)
          wait_for_overlay_no_ajax_wait
          if auto_driver_modal?
            wait_for_overlay_no_ajax_wait
            auto_driver_modal.save_and_continue
            sleep(2)
            wait_for_overlay_no_ajax_wait
          end
          sleep(5)
          wait_for_overlay_no_ajax_wait
          if premium_change_modal?
            wait_for_overlay_no_ajax_wait
            premium_change_modal.close
            sleep(2)
            wait_for_overlay_no_ajax_wait
            # wait_for_modal_to_close('premium_change_modal')
          end
        end
      end
    end
  end

  def single_order_button
    if clue_prefill_mvr_section.order_reports_element.present?
      if !clue_prefill_mvr_section.order_reports_element.disabled?
        scroll.to :top
        clue_prefill_mvr_section.order_reports
        sleep(2)
        wait_for_overlay_no_ajax_wait
        3.times do
          if report_results_modal?
            wait_for_overlay_no_ajax_wait
            if report_results_modal.save_and_continue_element.present?
              sleep(2)
              wait_for_overlay_no_ajax_wait
              report_results_modal.save_and_continue
            else
              wait_for_overlay_no_ajax_wait
              report_results_modal.save_and_close_btn_element.click if report_results_modal.save_and_close_btn_element.present?
            end
            sleep(2)
            wait_for_overlay_no_ajax_wait
          end
        end
        sleep(2)
        wait_for_overlay_no_ajax_wait
        if report_results_modal?
          if report_results_modal.apply_to_quotes?
            wait_for_overlay_no_ajax_wait
            if !report_results_modal.apply_to_quotes_element.disabled?
              report_results_modal.apply_to_quotes
              Watir::Wait.while { report_results_modal.apply_to_quotes? }
            end
            report_results_modal.dismiss_element.click if report_results_modal.apply_to_quotes_element.disabled?
            wait_for_overlay_no_ajax_wait
          end
        end
        sleep(2)
        wait_for_overlay_no_ajax_wait
        3.times do
          sleep(2)
          wait_for_overlay_no_ajax_wait
          if auto_driver_modal?
            wait_for_overlay_no_ajax_wait
            auto_driver_modal.save_and_continue if auto_driver_modal.save_and_continue?
            sleep(2)
            wait_for_overlay_no_ajax_wait
          end
        end
        sleep(2)
        wait_for_overlay_no_ajax_wait
        3.times do
          sleep(2)
          wait_for_overlay_no_ajax_wait
          if premium_change_modal?
            wait_for_overlay_no_ajax_wait
            premium_change_modal.close
            wait_for_overlay_no_ajax_wait
            # wait_for_modal_to_close('premium_change_modal')
          end
        end
        sleep(2)
        wait_for_overlay_no_ajax_wait
        if inspection_order_modal?
          wait_for_overlay_no_ajax_wait
          inspection_order_modal.submit_order
          wait_for_overlay_no_ajax_wait
        end
        sleep(2)
        wait_for_overlay_no_ajax_wait
        2.times do
          sleep(2)
          wait_for_overlay_no_ajax_wait
          if report_results_modal?
            wait_for_overlay_no_ajax_wait
            if report_results_modal.save_and_continue_element.present?
              wait_for_overlay_no_ajax_wait
              report_results_modal.save_and_continue
            elsif report_results_modal.save_and_close_btn_element.present?
              wait_for_overlay_no_ajax_wait
              report_results_modal.save_and_close_btn_element.click
            elsif  report_results_modal.apply_to_quotes_element.present?
              wait_for_overlay_no_ajax_wait
              report_results_modal.apply_to_quotes
            end
            sleep(2)
            wait_for_overlay_no_ajax_wait
          end
        end
        sleep(2)
        wait_for_overlay_no_ajax_wait
        if auto_driver_modal?
          wait_for_overlay_no_ajax_wait
          auto_driver_modal.save_and_continue
          sleep(2)
          wait_for_overlay_no_ajax_wait
        end
        sleep(5)
        wait_for_overlay_no_ajax_wait
        if premium_change_modal?
          wait_for_overlay_no_ajax_wait
          premium_change_modal.close
          sleep(2)
          wait_for_overlay_no_ajax_wait
          # wait_for_modal_to_close('premium_change_modal')
        end
      end
    end
  end

  def multiple_issues_to_resolve
    clue_prefill_mvr_section.expand_each_policy_reports
    # if clue_prefill_mvr_section.order_reports_rows.first.present?
    #   multiple_order_reports_button
    # end
    single_order_button
    # if !clue_prefill_mvr_section.order_reports_rows.first.present?
    #
    # end
  end

  def order_reports_modal
    3.times do
      if report_results_modal?
        wait_for_overlay_no_ajax_wait
        if report_results_modal.save_and_continue_element.present?
          sleep(2)
          wait_for_overlay_no_ajax_wait
          report_results_modal.save_and_continue
        else
          wait_for_overlay_no_ajax_wait
          report_results_modal.save_and_close_btn_element.click if report_results_modal.save_and_close_btn_element.present?
        end
        sleep(2)
        wait_for_overlay_no_ajax_wait
      end
    end
    sleep(2)
    3.times do
      if report_results_modal?
        if report_results_modal.apply_to_quotes?
          wait_for_overlay_no_ajax_wait
          if !report_results_modal.apply_to_quotes_element.disabled?
            report_results_modal.apply_to_quotes
            wait_for_overlay_no_ajax_wait
          end
          2.times do
            if report_results_modal?
              wait_for_overlay_no_ajax_wait
              if report_results_modal.save_and_continue_element.present?
                sleep(2)
                wait_for_overlay_no_ajax_wait
                report_results_modal.save_and_continue
              else
                wait_for_overlay_no_ajax_wait
                report_results_modal.save_and_close_btn_element.click if report_results_modal.save_and_close_btn_element.present?
              end
              sleep(2)
              wait_for_overlay_no_ajax_wait
            end
          end
        end
      end
    end
    sleep(2)
    3.times do
      sleep(2)
      if auto_driver_modal?
        wait_for_overlay_no_ajax_wait
        auto_driver_modal.save_and_continue if auto_driver_modal.save_and_continue?
        sleep(2)
        wait_for_overlay_no_ajax_wait
      end
    end
    sleep(2)
    3.times do
      sleep(2)
      if premium_change_modal?
        wait_for_overlay_no_ajax_wait
        premium_change_modal.close
        wait_for_overlay_no_ajax_wait
        # wait_for_modal_to_close('premium_change_modal')
      end
    end
    sleep(2)
    if inspection_order_modal?
      wait_for_overlay_no_ajax_wait
      inspection_order_modal.submit_order
      wait_for_overlay_no_ajax_wait
    end
    sleep(2)
    2.times do
      sleep(2)
      if report_results_modal?
        wait_for_overlay_no_ajax_wait
        if report_results_modal.save_and_continue_element.present?
          wait_for_overlay_no_ajax_wait
          report_results_modal.save_and_continue
        else
          wait_for_overlay_no_ajax_wait
          report_results_modal.save_and_close_btn_element.click if report_results_modal.save_and_close_btn_element.present?
        end
        sleep(2)
        wait_for_overlay_no_ajax_wait
      end
    end
    sleep(2)
    if auto_driver_modal?
      wait_for_overlay_no_ajax_wait
      auto_driver_modal.save_and_continue
      sleep(2)
      wait_for_overlay_no_ajax_wait
    end
    sleep(5)
    if premium_change_modal?
      wait_for_overlay_no_ajax_wait
      premium_change_modal.close
      sleep(2)
      wait_for_overlay_no_ajax_wait
    end
  end

  # def resolve_issues_to_resolve
  #   start = Time.now
  #   Timeout.timeout(Nenv.browser_timeout) do
  #     clue_prefill_mvr_section.order_all_reports
  #     Watir::Wait.until { auto_driver_modal? }
  #     auto_driver_modal.save_and_close if auto_driver_modal?
  #
  #     # This page is weird, clicking the order button causes the page to reload, then
  #     # when the page is reloaded - the modal opens.
  #     #Watir::Wait.until { auto_driver_modal? } if clue_prefill_mvr_section.order_all_reports
  #     #auto_driver_modal.save_and_close
  #   end
  # rescue Timeout::Error => e
  #   AppErrorHelper.screenshot_error(nil, self)
  #   stop = Time.now
  #   time = stop - start
  #   msg = "Reports Page - Order Reports Button"
  #   raise_page_loading(e, time, msg)
  # end
end
