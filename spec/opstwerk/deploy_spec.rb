require "spec_helper"
require "opstwerk/deploy"

module Opstwerk
  describe Deploy do
    subject { Deploy.new('derp') }

    context "#execute" do
      let(:client) { double }
      before do
        Client.stub(:new).with('derp').and_return(client)
      end

      it "creates a new deployment" do
        client.should_receive(:create_deployment).with(hash_including(command: { name: 'deploy' }))
        subject.execute
      end
    end

    context "#client" do
      it "generates a new aws client from the given configs" do
        Client.should_receive(:new).with('derp')
        subject.client
      end
    end

  end
end
