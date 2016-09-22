# get_unprovisioned_devices_from_hockey plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-get_unprovisioned_devices_from_hockey)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-get_unprovisioned_devices_from_hockey`, add it to your project by running:

```bash
fastlane add_plugin get_unprovisioned_devices_from_hockey
```

## About get_unprovisioned_devices_from_hockey

Retrieves a list of unprovisioned devices from Hockey which can be passed directly into register_devices. This will return the name and UDID for any user who has installed the HockeyApp profile on their phone but is not yet part of the provisioning profile. 

When used with `register_devices` and `match`, this will result in a workflow where you can ask users to log in and register their phone through rink.hockeyapp.net, then kick off a new build that will automatically be provisioned for their device.

get_unprovisioned_devices_from_hockey will use `FL_HOCKEY_API_TOKEN` for the Hockey API token, or it can be provided using the `api_token` parameter.

An example of how get_unprovisioned_devices_from_hockey is used:

```ruby
new_devices = get_unprovisioned_devices_from_hockey(app_bundle_id:'com.leandog.MyApp')
register_devices(devices: new_devices)
match(force: true)
```

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`. 

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

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/PluginsTroubleshooting.md) doc in the main `fastlane` repo.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Plugins.md).

## About `fastlane`

`fastlane` is the easiest way to automate building and releasing your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
