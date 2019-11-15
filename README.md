# ram_disk plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-ram_disk)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-ram_disk`, add it to your project by running:

```bash
fastlane add_plugin ram_disk
```

## About ram_disk

Use a temporary ram disk to do anything else, it contains three actions:

Action | Description
---|---
ram_disk | combo two action below and do something with a lambda
create_ram_disk | Create a virtual ram disk
remove_ram_disk | Remove a virtual ram disk

**Note to author:** Only works in macOS for now and add a more detailed description about this plugin here. If your plugin contains multiple actions, make sure to mention them here.

### ram_disk

```
+------------+-----------------------------------+---------------------+----------+
|                                ram_disk Options                                 |
+------------+-----------------------------------+---------------------+----------+
| Key        | Description                       | Env Var             | Default  |
+------------+-----------------------------------+---------------------+----------+
| name       | The name of ram disk              | RAM_DISK_NAME       |          |
| size       | The size of ram disk (unit is MB) | RAM_DISK_SIZE       |          |
| mount_path | The path of ram disk              | RAM_DISK_MOUNT_PATH | /Volumes |
| use        | The code of lamda to run          |                     |          |
+------------+-----------------------------------+---------------------+----------+
* = default value is dependent on the user's system

+---------------+----------------------+
|      ram_disk Output Variables       |
+---------------+----------------------+
| Key           | Description          |
+---------------+----------------------+
| RAM_DISK_PATH | the path of ram disk |
+---------------+----------------------+
Access the output values using `lane_context[SharedValues::VARIABLE_NAME]`
```

### create_ram_disk

```
+------------+-----------------------------------+---------------------+----------+
|                             create_ram_disk Options                             |
+------------+-----------------------------------+---------------------+----------+
| Key        | Description                       | Env Var             | Default  |
+------------+-----------------------------------+---------------------+----------+
| name       | The name of ram disk              | RAM_DISK_NAME       |          |
| size       | The size of ram disk (unit is MB) | RAM_DISK_SIZE       |          |
| mount_path | The path of ram disk              | RAM_DISK_MOUNT_PATH | /Volumes |
+------------+-----------------------------------+---------------------+----------+
* = default value is dependent on the user's system

+---------------+----------------------+
|   create_ram_disk Output Variables   |
+---------------+----------------------+
| Key           | Description          |
+---------------+----------------------+
| RAM_DISK_PATH | the path of ram disk |
+---------------+----------------------+
Access the output values using `lane_context[SharedValues::VARIABLE_NAME]`

+------------------------------+
| create_ram_disk Return Value |
+------------------------------+
| String                       |
+------------------------------+
```

### remove_ram_disk

```
+------+----------------------+---------------+---------+
|                remove_ram_disk Options                |
+------+----------------------+---------------+---------+
| Key  | Description          | Env Var       | Default |
+------+----------------------+---------------+---------+
| path | The path of ram disk | RAM_DISK_PATH |         |
+------+----------------------+---------------+---------+
```

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

**Note to author:** Please set up a sample project to make it easy for users to explore what your plugin does. Provide everything that is necessary to try out the plugin in this project (including a sample Xcode/Android project if necessary)

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
