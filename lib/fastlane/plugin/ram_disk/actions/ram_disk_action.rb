require 'fastlane/action'
require_relative '../helper/ram_disk_helper'

module Fastlane
  module Actions
    class RamDiskAction < Action
      def self.run(params)
        RamDisk::Manager.run(params)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Use a temporary ram disk to do anything else'
      end

      def self.available_options
        Fastlane::RamDisk::Options.available_options
      end

      def self.example_code
        [
          'use_ram_disk(
            name: "ramdisk"
            size: 4096,
            use: lambda {
              build_app(
                derived_data_path: Actions.lane_context[SharedValues::RAM_DISK_PATH]
              )
            }
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

      def self.authors
        ['icyleaf']
      end

      def self.is_supported?(_)
        true
      end
    end
  end
end
