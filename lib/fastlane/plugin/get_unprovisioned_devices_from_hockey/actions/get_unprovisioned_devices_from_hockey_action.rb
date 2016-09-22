module Fastlane
  module Actions
    module SharedValues
      HOCKEY_UNPROVISIONED_DEVICES = :HOCKEY_UNPROVISIONED_DEVICES
    end

    class GetUnprovisionedDevicesFromHockeyAction < Action
      def self.run(params)
        bundle_id = params[:app_bundle_id]
        api_token = params[:api_token]

        hockey_app_id = hockey_app_id_for_bundle_id(bundle_id, api_token)
        if hockey_app_id.empty?
          UI.user_error! "Could not find an app in Hockey with bundle ID matching #{bundle_id}"
        end

        devices = unprovisioned_devices_for_hockey_app_id(hockey_app_id, api_token)

        Actions.lane_context[SharedValues::HOCKEY_UNPROVISIONED_DEVICES] = devices
        devices
      end

      def self.description
        'Retrieves a list of unprovisioned devices from Hockey which can be passed directly into register_devices.'
      end

      def self.authors
        ['Gary Johnson']
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       env_name: 'FL_HOCKEY_API_TOKEN',
                                       description: 'API Token for Hockey'),
          FastlaneCore::ConfigItem.new(key: :app_bundle_id,
                                       description: 'App bundle identifier to get unprovisioned devices for (example: com.company.AppName).')
        ]
      end

      def self.return_value
        'The list of unprovisioned devices.'
      end

      def self.is_supported?(platform)
        true
      end

      private

      def self.http_for_hockey
        uri = URI('https://rink.hockeyapp.net')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http
      end

      def self.hockey_app_id_for_bundle_id(bundle_id, api_token)
        http = http_for_hockey

        uri_apps = URI('https://rink.hockeyapp.net/api/2/apps')
        request = Net::HTTP::Get.new(uri_apps)
        request['X-HockeyAppToken'] = api_token
        response = http.request(request)

        unless response.is_a?(Net::HTTPSuccess)
          UI.user_error! "An error occurred while retrieving list of apps from Hockey. Error #{response.code}: #{response.message}"
        end

        app_public_id = ''
        apps_response = JSON.parse(response.body)

        apps_response['apps'].each do |app|
          if app['bundle_identifier'] == bundle_id
            app_public_id = app['public_identifier']
          end
        end

        app_public_id
      end

      def self.unprovisioned_devices_for_hockey_app_id(hockey_app_id, api_token)
        http = http_for_hockey
        uri_devices = URI("https://rink.hockeyapp.net/api/2/apps/#{hockey_app_id}/devices?unprovisioned=1")
        request = Net::HTTP::Get.new(uri_devices)
        request['X-HockeyAppToken'] = api_token
        response = http.request(request)

        unless response.is_a?(Net::HTTPSuccess)
          UI.user_error! "An error occurred while getting devices from Hockey for app ID #{hockey_app_id}. Error #{response.code}: #{response.message}"
        end

        devices_response = JSON.parse(response.body)['devices']
        Hash[devices_response.collect { |item| [item['name'], item['udid']] }]
      end
    end
  end
end
