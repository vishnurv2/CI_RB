
##### this function is used to read the excel_data #######

Given(/^I have loaded test data from excel "([^"]*)"$/) do |worksheet|
  @excel_data_value = RubyExcelHelper.read_excel("./excel_data/#{worksheet}.xlsx")
end


Given(/^I load data from "([^"]*)" excel,worksheet as "([^"]*)" for (.*)$/) do |excel_file, sheet_name, test_name|
  DataMagic.yml = RubyExcelHelper.load_excel_for_test(sheet_name, test_name)
end

When(/^I add a vehicle from "([^"]*)" excel,worksheet as "([^"]*)" for (.*)$/) do |excel_file, sheet_name, test_name|
  DataMagic.yml = RubyExcelHelper.load_excel_for_test(sheet_name, test_name)
  ovm = DataMagic.yml['other_vehicle_modal']
  on(AutoPolicySummaryPage) do |page|
    page.vehicle_info_panel.add_button
    modal = page.other_vehicle_modal
    modal.populate_with(ovm)
    modal.save_and_close_button
    page.wait_for_ajax
  end
  @added_other_vehicle = {'year' => ovm['vehicle_year'], 'make' => ovm['vehicle_make'], 'model' => ovm['vehicle_model'], 'id' => ovm['vehicle_identification_number'], 'type' => ovm['type_of_vehicle']}
end

And(/^I load additonal party from "([^"]*)" excel,worksheet as "([^"]*)" for (.*)$/) do |excel_file, sheet_name, test_name|
  DataMagic.yml = RubyExcelHelper.load_excel_for_test(sheet_name, test_name)
end

Given(/^I load data from "([^"]*)" excel for (.*)$/) do |excel_file, test_name|
  DataMagic.yml = RubyExcelHelper.load_excel_for_test(test_name)
end

Given(/^I generate YAML for all keys present in "([^"]*)" excel$/) do |excel|
  RubyExcelHelper.bulk_generate_yaml
end

Given(/^I load the global excel$/) do
  @excel = RubyExcelHelper.fetch_global_excel_data
end

And(/^I delete all existing keys from redis cache$/) do
  RubyExcelHelper.flush_redis_cache
end

Then(/^I regenerate the cache$/) do
  RubyExcelHelper.check_for_duplicate_entries
  key_value_for_redis = RubyExcelHelper.generate_redis_cache
end

