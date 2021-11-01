And(/^I should be able to add (\d+) vacant addresses$/) do |num|
  @data_from_fixture = data_for('vacant_address_details')['panels']
  on(PolicyManagementPage) do |page|
    modal = page.parcels_of_vacant_land_modal
    count = 0
    num.times do
      modal.parcel_of_vacant_land
      modal.vacant_land_address[count].address_details.populate_with(@data_from_fixture[count])
      count = count +1
      modal.add_address if count < num
      page.wait_for_ajax
    end
    modal.save_and_close
  end
end

And(/^I should be able to add a vacant address$/) do
  on(PolicyManagementPage) do |page|
    modal = page.parcels_of_vacant_land_modal
    modal.parcel_of_vacant_land
    modal.save_and_close
  end
end