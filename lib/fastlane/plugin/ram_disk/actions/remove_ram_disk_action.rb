module Fastlane
  module Actions
    class RemoveRamDiskAction < Action
      def self.run(params)
        manager = RamDisk::Manager.new(params)
        manager.remove
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Remove a ram disk (use it after _create_ram_disk_ action)'
      end

      def self.available_options
        Fastlane::RamDisk::Options.remove_options
      end

      def self.example_code
        [
          'remove_ram_disk',
          'remove_ram_disk(path: "/Volumes/ramdisk")'
        ]
      end

      def self.category
        :building
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
