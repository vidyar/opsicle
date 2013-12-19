require "spec_helper"
require "opsicle/list"

module Opsicle
  describe List do
    subject { List.new('derp') }

    context "#execute" do
      let(:client) { double }
      let(:stack_ids) { [1,2,3] }
      let(:apps) { [{ name: 'test', stack_id: 1, app_id: 1}, { name: 'test2', stack_id: 2, app_id: 2}, { name: 'test3', stack_id: 3, app_id: 3 }] }
      before do
        Client.stub(:new).with('derp').and_return(client)
      end

      it "creates a new deployment" do
        subject.should_receive(:get_stacks).and_return(stack_ids)
        subject.should_receive(:get_apps).with(stack_ids).and_return(apps)
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
