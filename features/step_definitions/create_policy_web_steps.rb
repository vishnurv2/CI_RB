# frozen_string_literal: true
#

Then(/^I send account via email$/) do
  # on(PolicyManagementPage).quote_snapshot_modal.go_to_umbrella_summary
  # on(PolicyManagementPage).left_navigate_to_if_not_on('Account Overview')
  on(PolicyManagementPage) do |page|
    unless page.page_header_text.include? "Account Summary"
      page.left_nav.navigate_to('Account Overview')
    end
    # page.left_navigate_to_if_not_on("Referrals")
  end
  email = ENV['email']

  if email == "" || email.nil?
    email = "aneidert@central-insurance.com"
  end

  STDOUT.puts "Emailing the user: #{email}"

  url = @browser.url
  @account = url.split("/").last
  STDOUT.puts "Account: #{@policy}"

  subject = "Account Created: #{@account}"
  msg = "Your new account/policy has been created in the #{Nenv.test_env.upcase} environment:\n\n#{url}"

  AppErrorHelper._send_notification_email(subject, msg, email)

  env = Nenv.test_env
  effective_date = ENV['date']
  effective_date = DataMagic.today if effective_date.nil? || effective_date.length <= 0

  case @scenario_name
  when 'Basic Auto Policy'
    quote_type = 'IN-Auto Quote'
  when 'Fully Issuing a Policy'
    quote_type = 'IN-Auto Fully Issued'
  when 'HOME New Home Policy with'
    quote_type = 'IN-Home Quote'
  when 'Umbrella - Create new umbrella policy with no exposures'
    quote_type = 'IN-Umbrella Quote'
  when 'Policy issuance Scheduled Property'
    quote_type = 'IN-Scheduled Prop Quote'
  when 'Watercraft - Create new watercraft policy'
    quote_type = 'IN-Watercraft Quote'
  when 'Dwelling - Create new dwelling policy'
    quote_type = 'IN-Dwelling Quot'
  when 'Home Policy fully issuance'
    quote_type = 'IN-Home Fully Issued'
  when 'Policy issuance of Auto and Home'
    quote_type = 'IN-Home & IN-Auto Quote'
  when 'Umbrella - policy issuance'
    quote_type = 'IN-Umbrella Fully Issued'
  when 'Policy issuance of Auto and Umbrella'
    quote_type = 'IN-Umbrella & IN-Auto Quote'
  end

  sql =  "insert into policy_details (env, effective_date, policy_url, quote_type, email_address) values ('#{env}','#{effective_date}','#{url}','#{quote_type}','#{email}');"
  data = DatabaseHelper::Database.execute(database: 'pg', stmt: sql)
  STDOUT.puts 'Data has been pushed to the Postgres DB'

  data

end


Given(/^I modify the effective dates$/) do
  effective_date = ENV['effective_date']
  unless effective_date.nil? || effective_date.length <= 0
    DataMagic.yml['add_product_modal']['policy_effective_date'] = effective_date
    DataMagic.yml['auto_general_info_modal']['effective_date'] = effective_date

    if Chronic.parse(effective_date) < Chronic.parse('11/01/2020') && DataMagic.yml.keys.include?('auto_vehicle_modal')
      if DataMagic.yml['auto_vehicle_modal'].keys.include?('purchase_date')
        DataMagic.yml['auto_vehicle_modal'].delete('purchase_date')
      end
      if DataMagic.yml['auto_vehicle_modal'].keys.include?('annual_miles')
        DataMagic.yml['auto_vehicle_modal'].delete('annual_miles')
      end
    end
  end
end
