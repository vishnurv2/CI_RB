Then(/^I order reports and resolve itv no hit$/) do
  on(PolicyManagementPage).left_nav.navigate_to('Reports')
  on(ReportsPage) do |page|
    page.clue_prefill_mvr_section.order_reports
    page.wait_for_overlay_no_ajax_wait
    if page.report_results_modal?
      if page.report_results_modal.save_and_close_btn?
        sleep(1)
        page.wait_for_overlay_no_ajax_wait
        page.report_results_modal.save_and_close_btn
        sleep(2)
        Watir::Wait.while { page.report_results_modal.save_and_close_btn? }
        page.wait_for_overlay_no_ajax_wait
      end
      sleep(2)
      page.wait_for_overlay_no_ajax_wait
    end
    report = page.clue_prefill_mvr_section.reports_grid.find { |i| i.type.include? "ITV" if i.type? }
    report.edit_report
    page.wait_for_ajax
    if page.report_results_modal?
      page.report_results_modal.modify_itv
    end
  end
  Watir::Wait.until { @browser.url.include?('https://rcttest7.msbexpress.net/central/ValuationEditor') }
  on(RCTExpressPage) do |page|
    page.wait_for_loading_overlay_to_close
    modal = page.edit_building_modal
    modal.select_home_style = '1 Story'
    page.wait_for_loading_overlay_to_close
    modal.year_built = '1990'
    modal.finished_living_area = '123'
    modal.wall_height_element.click
    page.wait_for_loading_overlay_to_close
    modal.save_building_button_element.click
    Watir::Wait.while { modal.present? }
    page.wait_for_loading_overlay_to_close
    page.finish_element.click
    page.wait_for_loading_overlay_to_close
    modal = page.confirmation_modal
    modal.save
    page.wait_for_loading_overlay_to_close
  end
  Watir::Wait.until { @browser.url.include?('PolicyAdminWeb/PL/reports') }
  on(ReportsPage) do |page|
    sleep(2)
    if page.report_results_modal?
      sleep(2)
      if page.report_results_modal.apply_to_quotes?
        page.wait_for_overlay_no_ajax_wait
        page.report_results_modal.apply_to_quotes
        Watir::Wait.while { page.report_results_modal? }
        page.wait_for_overlay_no_ajax_wait
      end
    end
  end
end