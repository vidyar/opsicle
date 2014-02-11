require "spec_helper"
require "opsicle/ssh"

module Opsicle
  describe SSH do
    subject { SSH.new('derp') }
    let(:client) { double(config: double(opsworks_config: {stack_id: "1234"})) }
    let(:api_call) { double }
    before do
      Client.stub(:new).with('derp').and_return(client)
    end

    context "#execute" do
      before do
        subject.stub(:say) { "What instance do you want, huh?" }
        subject.stub(:ask).and_return(2)
        subject.stub(:ssh_username) {"mrderpyman2014"}
      end

      it "should execute ssh with a selected Opsworks instance IP" do
        subject.stub(:instances) {[
                                    { hostname: "host1", elastic_ip: "123.123.123.123" },
                                    { hostname: "host2", elastic_ip: "789.789.789.789" }
                                  ]}

        subject.should_receive(:system).with("ssh mrderpyman2014@789.789.789.789")
        subject.execute
      end

      it "should execute ssh right away if there is only one Opsworks instance available" do
        subject.stub(:instances) {[
                                    { hostname: "host3", elastic_ip: "456.456.456.456" }
                                  ]}

        subject.should_receive(:system).with("ssh mrderpyman2014@456.456.456.456")
        subject.should_not_receive(:ask)
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
      it "makes a describe_instances API call" do
        client.stub(:api_call).with(:describe_instances, {stack_id: "1234"})
          .and_return(api_call)
        api_call.should_receive(:data).and_return(instances: {:foo => :bar})
        subject.instances.should == {:foo => :bar}
      end
    end

    context "#ssh_username" do
      it "makes a describe_my_user_profile API call" do
        client.stub(:api_call).with(:describe_my_user_profile)
          .and_return({user_profile: {:ssh_username => "captkirk01"}})
        subject.ssh_username.should == "captkirk01"
      end
    end

  end
end
