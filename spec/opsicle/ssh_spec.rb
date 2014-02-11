require "spec_helper"
require "opsicle/ssh"

module Opsicle
  describe SSH do
    subject { SSH.new('derp') }

    context "#execute" do
      let(:client) { double }
      before do
        Client.stub(:new).with('derp').and_return(client)
      end

      it "should execute ssh with a selected Opsworks instance IP" do
        subject.stub(:say) { "What instance do you want, huh?" }
        subject.stub(:instances) {[
                                    { hostname: "host1", elastic_ip: "123.123.123.123" },
                                    { hostname: "host2", elastic_ip: "789.789.789.789" }
                                  ]}
        subject.stub(:ask).and_return(2)

        subject.should_receive(:system).with("ssh 789.789.789.789")
        subject.execute
      end
    end

    context "#client" do
      it "generates a new aws client from the given configs" do
        Client.should_receive(:new).with('derp')
        subject.client
      end
    end

    context "#instances" do
      let(:client) { double(config: double(opsworks_config: {stack_id: "1234"})) }
      let(:api_call) { double }
      before do
        Client.stub(:new).with('derp').and_return(client)
      end

      it "makes a describe_instances API call" do
        client.stub(:api_call).with(:describe_instances, {stack_id: "1234"})
                              .and_return(api_call)
        api_call.should_receive(:data).and_return(instances: {:foo => :bar})
        subject.instances.should == {:foo => :bar}
      end
    end

  end
end
