# frozen_string_literal: true

When(/^I add a manual (other vehicle|vehicle|policy optional) coverage$/) do |vehicle_or_policy_coverage|
  #@coverage = data_for('manual_coverage')
  @coverage = DataMagic.yml['manual_coverage']
  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :center
    sleep(0.25)
    page.send("open_#{vehicle_or_policy_coverage.snakecase}_coverages")
    #page.wait_for_ajax just testing this???
    modal = vehicle_or_policy_coverage.include?('vehicle') ? page.auto_vehicle_coverages_modal : page.auto_policy_optional_coverages_modal
    #page.wait_for_ajax
    Watir::Wait.until { modal.manual_coverage_element.present? }
    modal.manual_coverage = true
    Watir::Wait.until { modal.manual_coverages.count > 0 }
    modal.manual_coverages.first.description = @coverage['description']
    modal.manual_coverages.first.premium = @coverage['premium']
    #modal.save_and_close  This is a hack to bypass something weird Preeti did in one of her checkins.
    # we keep detecting something in wait_for_ajax
    modal.save_and_close_button
  end
end

When(/^I delete the manual (other vehicle|vehicle|policy optional) coverage I added$/) do |vehicle_or_policy_coverage|
  @browser.refresh
  on(AutoPolicySummaryPage) do |page|
    sleep(0.25)
    page.send("open_#{vehicle_or_policy_coverage.snakecase}_coverages")
    page.wait_for_modal_or_error_take_picture
    modal = vehicle_or_policy_coverage.include?('vehicle') ? page.auto_vehicle_coverages_modal : page.auto_policy_optional_coverages_modal
    sleep(1)
    modal.manual_coverages.first.delete
    modal.save_and_close_button
    page.wait_for_overlay_no_ajax_wait
  end
end

Then(/^I (should|should not) see the manual (other vehicle|vehicle|policy optional) coverage I added$/) do |should_or_not, vehicle_or_policy_coverage|
  @coverage = data_for('manual_coverage')
  @browser.refresh
  on(AutoPolicySummaryPage) do |page|
    page.scroll.to :center
    sleep(0.25)
    page.send("open_#{vehicle_or_policy_coverage.snakecase}_coverages")
    modal = vehicle_or_policy_coverage.include?('vehicle') ? page.auto_vehicle_coverages_modal : page.auto_policy_optional_coverages_modal
    whether_should = should_or_not == 'should'
    RSpec.capture_assertions do
      if whether_should
        Watir::Wait.until { modal.manual_coverages.count > 0 && !modal.manual_coverages.first.description.nil? }
        expect(modal.manual_coverages.first.description == @coverage['description']).to be_truthy, "Expected the first manual coverage to have a description of #{@coverage['description']}"
        expect(modal.manual_coverages.first.premium.gsub('.00','') == "$#{@coverage['premium']}".gsub('.00','')).to be_truthy, "Expect the first manual coverage to have a premium of #{@coverage['premium']}"
      else
        expect(modal.manual_coverages.count < 1 || modal.manual_coverages.first.description != @coverage['description']).to be_truthy, "Expected not to find a manual coverage with the description #{@coverage['description']}, but it was found"
        expect(modal.manual_coverages.count < 1 || modal.manual_coverages.first.premium.gsub('.00','') != "$#{@coverage['premium']}".gsub('.00','')).to be_truthy, "Expected not to find a manual coverage with the premium #{@coverage['premium']}, but it was found"
      end
    end
  end
end
