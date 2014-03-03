require "spec_helper"
require "opsicle/commands/deploy"

module Opsicle
  describe Deploy do
    subject { Deploy.new('derp') }

    context "#execute" do
      let(:client) { double }
      before do
        allow(Client).to receive(:new).with('derp').and_return(client)
      end

      it "creates a new deployment" do
        expect(subject).to receive(:open_deploy).with('derp')
        expect(client).to receive(:run_command).with('deploy').and_return({deployment_id: 'derp'})
        subject.execute
      end
    end

    context "#client" do
      it "generates a new aws client from the given configs" do
        expect(Client).to receive(:new).with('derp')
        subject.client
      end
    end

  end
end
