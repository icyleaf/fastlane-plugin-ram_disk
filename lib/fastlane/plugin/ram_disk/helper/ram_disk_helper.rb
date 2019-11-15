require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class RamDiskHelper
      # class methods that you define here become available in your action
      # as `Helper::RamDiskHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the ram_disk plugin helper!")
      end

      def self.mac?
        require 'rbconfig'

        platform = RbConfig::CONFIG['host_os']
        platform.include?('darwin')
      end
    end
  end
end
