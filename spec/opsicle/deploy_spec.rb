require "spec_helper"
require "opsicle/deploy"

module Opsicle
  describe Deploy do
    subject { Deploy.new('derp') }

    context "#execute" do
      let(:client) { double }
      before do
        Client.stub(:new).with('derp').and_return(client)
      end

      it "creates a new deployment" do
        subject.should_receive(:open_deploy).with('derp')
        client.should_receive(:run_command).with('deploy').and_return({deployment_id: 'derp'})
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
