Then(/^I gather additional data for auto declaration pdf$/) do

  # Insured address details
  @insured_name_address_1 = @doc.xpath('.//AddresseeInfo').css('NameAddress1').text.upcase
  @insured_name_address_2 = @doc.xpath('.//AddresseeInfo').css('NameAddress2').text
  @insured_name_address_3 = @doc.xpath('.//AddresseeInfo').css('NameAddress3').text

  # Agent address details
  @agent_name_address =  @doc.xpath('.//AgencyInfo').css('NameAddress')[0].text
  @agent_name_address_1 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[1].text
  @agent_name_address_2 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[2].text
  @website_address = @doc.xpath('.//AgencyInfo').css('WebSite').text

  # policy related details
  @policy_number = @doc.xpath('.//PolicyInformation').css('PolicyNumber').text
  @policy_symbol = @doc.xpath('.//PolicyInformation').css('PolicySymbol').text
  @total_premium = @doc.xpath('.//TotalPremium')[0].text

  #Vehicle Details
  @vehicle_state = @doc.xpath('.//VehicleData').css('State').text
  @vehicle_territory = @doc.xpath('.//VehicleData').css('Territory').text
  @vehicle_year = @doc.xpath('.//VehicleData').css('Year').text
  @vehicle_make = @doc.xpath('.//VehicleData').css('Make').text
  @vehicle_vin = @doc.xpath('.//VehicleData').css('Vin').text
  @vehicle_symbol = @doc.xpath('.//VehicleData').css('Symbol').text
  @vehicle_class = @doc.xpath('.//VehicleData').css('Class').text

  #Coverage Details 1
  @coverage_premium_a = @doc.xpath('.//VehicleCoverageGroup')[0].css('Vehicle1').text
  @coverage_premium_b = @doc.xpath('.//VehicleCoverageGroup')[1].css('Vehicle1').text
  @coverage_premium_c = @doc.xpath('.//VehicleCoverageGroup')[2].css('Vehicle1').text
  @coverage_premium_d = @doc.xpath('.//VehicleCoverageGroup')[3].css('Vehicle1').text
  #@coverage_premium_e = @doc.xpath('.//VehicleCoverageGroup')[4].css('Vehicle1').text
  #@coverage_premium_f = @doc.xpath('.//VehicleCoverageGroup')[5].css('Vehicle1').text
  #@coverage_premium_g = @doc.xpath('.//VehicleCoverageGroup')[6].css('Vehicle1').text
  #@coverage_premium_h = @doc.xpath('.//VehicleCoverageGroup')[7].css('Vehicle1').text
  #@vehicle_annual_premium = @doc.xpath('.//TotalPremiums').css('Vehicle1').text

  ### ADDITIONAL COVERAGES  ### Information
  # @additional_coverage_title_text = @doc.xpath('.//PolicyCoverageGroup').css('Line')[0].text
  #@additional_coverage_text_1 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[1].text
  # @additional_coverage_text_2 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[2].text
  #@additional_coverage_text_3 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[3].text
  #@additional_coverage_text_4 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[4].text
  #@additional_coverage_text_5 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[5].text
  #@additional_coverage_text_6 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[6].text
  #@additional_coverage_text_7 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[7].text
  #@additional_coverage_text_8 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[8].text
  #@additional_coverage_text_9 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[9].text
  # @additional_coverage_text_10 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[10].text
  #@additional_coverage_text_11 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[11].text
  # @additional_coverage_text_12 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[12].text
  # @additional_coverage_text_13 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[13].text
  #@additional_coverage_text_14 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[14].text
  #@additional_coverage_text_15 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[15].text
  #@additional_coverage_text_16 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[16].text
  #@additional_coverage_text_17 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[17].text
  #@additional_coverage_text_18 = @doc.xpath('.//PolicyCoverageGroup').css('Line')[18].text


end

Then(/^I validate auto declaration pdf$/) do
  ## Data from automation
  # binding.pry
  my_pdf = @document_location
  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [@insured_name_address_1, @insured_name_address_2, @insured_name_address_3,
                 @agent_name_address, @agent_name_address_1, @agent_name_address_2,
                 @policy_number, @policy_symbol, @total_premium,  @website_address,
                 @vehicle_state, @vehicle_territory, @vehicle_year, @vehicle_make, @vehicle_vin,
                 @vehicle_symbol, @vehicle_class]
    arr_second = [@coverage_premium_a, @coverage_premium_b, @coverage_premium_c, @coverage_premium_d]
    arr_third = []
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 3
        arr_third.each do |str|
          expect(page.text.include? str.strip).to be_truthy, "String #{str} is not found in the pdf"
          if(expect(page.text.include? str.strip).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I gather additional data for home declaration pdf$/) do
  @insured_name_address_1 = @doc.xpath('.//AddresseeInfo').css('NameAddress1').text.upcase
  @insured_name_address_2 = @doc.xpath('.//AddresseeInfo').css('NameAddress2').text
  @insured_name_address_3 = @doc.xpath('.//AddresseeInfo').css('NameAddress3').text

  # Agent address details
  @agent_name_address =  @doc.xpath('.//AgencyInfo').css('NameAddress')[0].text
  @agent_name_address_1 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[1].text
  @agent_name_address_2 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[2].text
  @website_address = @doc.xpath('.//AgencyInfo').css('WebSite').text

  # policy related details
  @policy_number = @doc.xpath('.//PolicyInformation').css('PolicyNumber').text
  @policy_symbol = @doc.xpath('.//PolicyInformation').css('PolicySymbol').text
  @total_premium = @doc.xpath('.//Coverages').css('TotalAnnualPremium').text

  # Discounts Details
  @discount_name_0 = @doc.xpath('.//IndentedDiscounts').css('DiscountName')[0].text
  @discount_name_1 = @doc.xpath('.//IndentedDiscounts').css('DiscountName')[1].text
  # @discount_name_2 = @doc.xpath('.//IndentedDiscounts').css('DiscountName')[2].text
  # @discount_name_3 = @doc.xpath('.//IndentedDiscounts').css('DiscountName')[3].text
  # @discount_name_4 = @doc.xpath('.//IndentedDiscounts').css('DiscountName')[4].text
  # @discount_name_5 = @doc.xpath('.//IndentedDiscounts').css('DiscountName')[5].text

  # Deductible Section detail
  @deductible_message = @doc.xpath('.//Deductible').css('Message')[0].text

  # Coverage Details section 1
  @coverage_type_a = @doc.xpath('.//Section1').css('Description')[0].text
  @coverage_limit_a = @doc.xpath('.//Section1').css('Limit')[0].text

  @coverage_type_b = @doc.xpath('.//Section1').css('Description')[1].text
  @coverage_limit_b = @doc.xpath('.//Section1').css('Limit')[1].text

  @coverage_type_c = @doc.xpath('.//Section1').css('Description')[2].text
  @coverage_limit_c = @doc.xpath('.//Section1').css('Limit')[2].text

  @coverage_type_d = @doc.xpath('.//Section1').css('Description')[3].text
  @coverage_limit_d = @doc.xpath('.//Section1').css('Limit')[3].text

  # Coverage Details section 1

  @coverage_type_e = @doc.xpath('.//Section2').css('Description')[0].text
  @coverage_limit_e = @doc.xpath('.//Section2').css('Limit')[0].text

  # @coverage_type_f = @doc.xpath('.//Section2').css('Description')[1].text
  # @coverage_limit_f = @doc.xpath('.//Section2').css('Limit')[1].text

end

Then(/^I validate home declaration pdf$/) do

  my_pdf = @document_location
  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [@insured_name_address_1, @insured_name_address_2, @insured_name_address_3,
                 @agent_name_address, @agent_name_address_1, @agent_name_address_2, @website_address,
                 @policy_number, @policy_symbol, @total_premium,
                 @discount_name_0, @discount_name_1, @deductible_message]
    arr_second = [@coverage_type_a, @coverage_limit_a, @coverage_type_b, @coverage_limit_b,
                  @coverage_type_c, @coverage_limit_c, @coverage_type_d, @coverage_limit_d,
                  @coverage_type_e, @coverage_limit_e]
    arr_third = []
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 3
        arr_third.each do |str|
          expect(page.text.include? str.strip).to be_truthy, "String #{str} is not found in the pdf"
          if(expect(page.text.include? str.strip).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I gather additional data for scheduled declaration pdf$/) do
  @insured_name_address_1 = @doc.xpath('.//AddresseeInfo').css('NameAddress1').text.upcase
  @insured_name_address_2 = @doc.xpath('.//AddresseeInfo').css('NameAddress2').text
  @insured_name_address_3 = @doc.xpath('.//AddresseeInfo').css('NameAddress3').text

  # Agent address details
  @agent_name_address =  @doc.xpath('.//AgencyInfo').css('NameAddress')[0].text
  @agent_name_address_1 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[1].text
  @agent_name_address_2 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[2].text
  @website_address = @doc.xpath('.//AgencyInfo').css('WebSite').text

  # policy related details
  @policy_number = @doc.xpath('.//PolicyInformation').css('PolicyNumber').text
  @policy_symbol = @doc.xpath('.//PolicyInformation').css('PolicySymbol').text
  @total_premium = @doc.xpath('.//TotalPremium')[0].text
end

Then(/^I validate scheduled declaration pdf$/) do
  my_pdf = @document_location
  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [@insured_name_address_1, @insured_name_address_2, @insured_name_address_3,
                 @agent_name_address, @agent_name_address_1, @agent_name_address_2, @website_address,
                 @policy_number, @policy_symbol, @total_premium]
    arr_second = []
    arr_third = []
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 3
        arr_third.each do |str|
          expect(page.text.include? str.strip).to be_truthy, "String #{str} is not found in the pdf"
          if(expect(page.text.include? str.strip).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I gather additional data for Watercraft declaration pdf$/) do
  @insured_name_address_1 = @doc.xpath('.//AddresseeInfo').css('NameAddress1').text.upcase
  @insured_name_address_2 = @doc.xpath('.//AddresseeInfo').css('NameAddress2').text
  @insured_name_address_3 = @doc.xpath('.//AddresseeInfo').css('NameAddress3').text

  # Agent address details
  @agent_name_address =  @doc.xpath('.//AgencyInfo').css('NameAddress')[0].text
  @agent_name_address_1 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[1].text
  @agent_name_address_2 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[2].text
  @website_address = @doc.xpath('.//AgencyInfo').css('WebSite').text

  # policy related details
  @policy_number = @doc.xpath('.//PolicyInformation').css('PolicyNumber').text
  @policy_symbol = @doc.xpath('.//PolicyInformation').css('PolicySymbol').text
  @total_premium = @doc.xpath('.//TotalPremium')[0].text
end

Then(/^I validate Watercraft declaration pdf$/) do
  my_pdf = @document_location
  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [@insured_name_address_1, @insured_name_address_2, @insured_name_address_3,
                 @agent_name_address, @agent_name_address_1, @agent_name_address_2, @website_address,
                 @policy_number, @policy_symbol, @total_premium]
    arr_second = []
    arr_third = []
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 3
        arr_third.each do |str|
          expect(page.text.include? str.strip).to be_truthy, "String #{str} is not found in the pdf"
          if(expect(page.text.include? str.strip).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end

Then(/^I gather additional data for Dwelling declaration pdf$/) do
  @insured_name_address_1 = @doc.xpath('.//AddresseeInfo').css('NameAddress1').text.upcase
  @insured_name_address_2 = @doc.xpath('.//AddresseeInfo').css('NameAddress2').text
  @insured_name_address_3 = @doc.xpath('.//AddresseeInfo').css('NameAddress3').text

  # Agent address details
  @agent_name_address =  @doc.xpath('.//AgencyInfo').css('NameAddress')[0].text
  @agent_name_address_1 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[1].text
  @agent_name_address_2 =  @doc.xpath('.//AgencyInfo').css('NameAddress')[2].text
  @website_address = @doc.xpath('.//AgencyInfo').css('WebSite').text

  # policy related details
  @policy_number = @doc.xpath('.//PolicyInformation').css('PolicyNumber').text
  @policy_symbol = @doc.xpath('.//PolicyInformation').css('PolicySymbol').text
  @total_premium = @doc.xpath('.//TotalPremium')[0].text
end

Then(/^I validate Dwelling declaration pdf$/) do
  my_pdf = @document_location
  PDF::Reader.open(File.open(my_pdf, "rb")) do |reader|

    arr_first = [@insured_name_address_1, @insured_name_address_2, @insured_name_address_3,
                 @agent_name_address, @agent_name_address_1, @agent_name_address_2, @website_address,
                 @policy_number, @policy_symbol, @total_premium]
    arr_second = []
    arr_third = []
    reader.pages.each do |page|
      if page.number == 1
        arr_first.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 2
        arr_second.each do |str|
          expect(page.text.include? str).to be_truthy, "String #{str} is not found in the pdf"
          if (expect(page.text.include? str).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF at Page : #{page.number}"
          end
        end
      elsif page.number == 3
        arr_third.each do |str|
          expect(page.text.include? str.strip).to be_truthy, "String #{str} is not found in the pdf"
          if(expect(page.text.include? str.strip).to be_truthy) == true
            puts "Expected String : #{str} is found in PDF, at Page : #{page.number}"
          end
        end
      end
    end
  end
end