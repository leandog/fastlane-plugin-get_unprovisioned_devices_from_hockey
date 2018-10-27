# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/get_unprovisioned_devices_from_hockey/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-get_unprovisioned_devices_from_hockey'
  spec.version       = Fastlane::GetUnprovisionedDevicesFromHockey::VERSION
  spec.author        = ['GaryJohnson', 'kumichou']
  spec.email         = ['gary@gjtt.com', 'eric.hankinson@gmail.com']

  spec.summary       = 'Retrieves a list of unprovisioned devices from Hockey which can be passed directly into register_devices.'
  spec.homepage = 'https://github.com/leandog/fastlane-plugin-get_unprovisioned_devices_from_hockey'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*'] + %w[README.md LICENSE]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'json'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'fastlane', '>= 1.103.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
