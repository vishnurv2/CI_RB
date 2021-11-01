Then(/^I save policy number to the text file$/) do
  data = {
    "Policy Number" => @number
  }

  File.open("./text_file_data/test_data_#{Nenv.test_env}.txt", 'w') do |f|
    data.each do |name, data|
      f.puts "#{name}: #{data}"
    end
  end
end

Then(/^I save policy number from the text file$/) do
  data = Hash[File.read("./text_file_data/test_data_#{Nenv.test_env}.txt").split("\n").map{|i|i.split(': ')}]
  @number = data["Policy Number"]
end