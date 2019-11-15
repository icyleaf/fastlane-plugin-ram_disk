# frozen_string_literal: true

require 'fastlane_core/configuration/config_item'

module Fastlane
  module Actions
    module SharedValues
      RAM_DISK_PATH = :RAM_DISK_PATH
    end
  end

  module RamDisk
    class Manager
      def self.run(params)
        instance = new(params)
        instance.create
        params[:use].call
        instance.remove
      end

      def initialize(params)
        @params = params
        UI.user_error!('Sorry, it only works in macOS for now') unless mac?
      end

      def create
        name = @params[:name]
        path = @params[:mount_path]
        size = @params[:size]
        ram_disk_path = File.join(path, name)

        UI.user_error!('the name is empty') if name.to_s.empty?
        UI.user_error!('the disk size is zero or negative') if size.to_i <= 0
        UI.user_error!("mount path existed: #{ram_disk_path}") if File.exist?(ram_disk_path)

        commands = []
        commands << create_ram_disk(name, size)
        commands << spotlight_indexes(ram_disk_path, true)

        commands.each do |shell_command|
          if Helper.test?
            UI.message("$ #{shell_command}")
            next
          end

          Actions.sh(shell_command)
        end

        UI.crash! "fail to create ram disk" unless Dir.exist?(ram_disk_path)

        UI.success "Successful on ram disk: #{ram_disk_path}"
        shared_value(Actions::SharedValues::RAM_DISK_PATH, ram_disk_path)
      end

      def remove
        path = @params[:path]

        UI.user_error!('ram path is empty') if path.to_s.empty?
        UI.user_error!("ram path is not exist: #{path}") unless Dir.exist?(path)
        UI.message("Found ram disk: #{path}")

        commands = []
        commands << spotlight_indexes(path, false)
        commands << remove_ram_disk(path)

        commands.each do |shell_command|
          if Helper.test?
            UI.message("$ #{shell_command}")
            next
          end

          Actions.sh(shell_command)
        end

        UI.crash! "fail to remove ram disk" if Dir.exist?(path)
      end

      def mac?
        require 'rbconfig'

        platform = RbConfig::CONFIG['host_os']
        platform.include?('darwin')
      end

      private

      def create_ram_disk(name, size)
        attch_ram = "hdiutil attach -nomount ram://$[#{size}*2048]"
        disk_path = (Helper.test? ? "'#{attch_ram}'" : `#{attch_ram}`.chomp)

        "diskutil erasevolume HFS+ #{name} #{disk_path}"
      end

      def remove_ram_disk(path)
        "diskutil eject #{path}"
      end

      def spotlight_indexes(path, value)
        value = value ? 'on' : 'off'
        "mdutil -i #{value} #{path}"
      end

      def shared_value(key, value)
        return Actions.lane_context[key] || ENV[key.to_s] unless value

        Actions.lane_context[key] = value
        ENV[key.to_s] = value
      end
    end

    class Options
      class << self
        def available_options
          @available_options ||= available_options
        end

        def available_create_options
          @create_options ||= create_options
        end

        def available_remove_options
          @remove_options ||= remove_options
        end

        def available_options
          create_options.concat([
            FastlaneCore::ConfigItem.new(key: :use,
                                        description: 'The code of lamda to run',
                                        is_string: false,
                                        verify_block: proc do |value|
                                          UI.user_error!('Please pass a lambda in Fastfile') unless value.respond_to?(:call)
                                        end)
          ])
        end

        def create_options
          [
            FastlaneCore::ConfigItem.new(key: :name,
                                        env_name: 'RAM_DISK_NAME',
                                        description: 'The name of ram disk',
                                        type: String),
            FastlaneCore::ConfigItem.new(key: :size,
                                        env_name: 'RAM_DISK_SIZE',
                                        description: 'The size of ram disk (unit is MB)',
                                        type: String),
            FastlaneCore::ConfigItem.new(key: :mount_path,
                                        env_name: 'RAM_DISK_MOUNT_PATH',
                                        description: 'The path of ram disk',
                                        optional: true,
                                        default_value: '/Volumes',
                                        type: String)
          ]
        end

        def remove_options
          [
            FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: 'RAM_DISK_PATH',
                                       description: 'The path of ram disk',
                                       optional: true,
                                       default_value: Actions.lane_context[Actions::SharedValues::RAM_DISK_PATH],
                                       type: String)
          ]
        end
      end
    end
  end
end
