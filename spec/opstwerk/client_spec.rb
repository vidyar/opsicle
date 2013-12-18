require "spec_helper"
require "opstwerk/client"

module Opstwerk
  describe Client do
    subject { Client.new('derp') }
    let(:aws_client) { double }
    let(:config) { double }
    before do
      ow_stub = double
      config.stub(:opsworks_config).and_return({ stack_id: 'stack', app_id: 'app' })
      ow_stub.stub(:client).and_return(aws_client)
      Config.stub(:new).and_return(config)
      AWS::OpsWorks.stub(:new).and_return(ow_stub)
    end

    context "#run_command" do
      it "calls out to the aws client with all the config options" do
        config.should_receive(:configure_aws!)
        aws_client.should_receive(:create_deployment).with(
          hash_including(
            command: { name: 'deploy' },
            stack_id: 'stack',
            app_id: 'app'
          )
        )
        subject.run_command('deploy')
      end
    end
  end
end
