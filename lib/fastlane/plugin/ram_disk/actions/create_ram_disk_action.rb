require 'fastlane/action'
require_relative '../helper/ram_disk_helper'

module Fastlane
  module Actions
    class CreateRamDiskAction < Action
      def self.run(params)
        manager = RamDisk::Manager.new(params)
        manager.create
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Use a temporary ram disk to do anything else"
      end

      def self.authors
        ["icyleaf"]
      end

      def self.example_code
        [
          'create_ram_disk(
            name: "ramdisk"
            size: 4096
          )',
          'create_ram_disk(
            name: "ramdisk",
            path: "/Volumes",
            size: 4096
          )'
        ]
      end

      def self.category
        :building
      end

      def self.output
        [
          ['RAM_DISK_PATH', 'the path of ram disk']
        ]
      end

      def self.return_value
        String
      end

      def self.available_options
        Fastlane::RamDisk::Options.create_options
      end

      def self.is_supported?(_)
        true
      end
    end
  end
end
