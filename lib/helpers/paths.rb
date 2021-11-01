# frozen_string_literal: true

module Helpers
  class PathHelper
    def self.create_paths
      %w[screenshot log download report].each do |which|
        FileUtils.mkdir_p Nenv.send("#{which}_dir")
      end
    end
  end
end
