describe Fastlane::Actions::GetUnprovisionedDevicesFromHockeyAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The get_unprovisioned_devices_from_hockey plugin is working!")

      Fastlane::Actions::GetUnprovisionedDevicesFromHockeyAction.run(nil)
    end
  end
end
