# frozen_string_literal: true

# monkey patch string
class String
  # Convert a string to a page class name 'auto policy'.to_page_class becomes 'AutoPolicyPage'
  # @return [String]
  def to_page_class
    "#{modulize}Page".delete(' ')
  end
end
