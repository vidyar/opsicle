require "spec_helper"
require "opstwerk/config"
module Opstwerk
  describe Config do
    subject { Config.new('derp') }
     before do
       YAML.stub(:load_file).with('~/.fog').and_return({'derp' => { 'access_key_id' => 'key', 'secret_access_key' => 'secret'}})
       YAML.stub(:load_file).with('.opstwerk').and_return({'derp' => { 'app_id' => 'app', 'stack_id' => 'stack'}})
     end

    context "#aws_config" do
      it "should contain access_key_id" do
        subject.aws_config.should have_key(:access_key_id)
      end

      it "should contain secret_access_key" do
        subject.aws_config.should have_key(:secret_access_key)
      end
    end

    context "#opsworks_config" do
      it "should contain stack_id" do
        subject.opsworks_config.should have_key(:stack_id)
      end

      it "should contain app_id" do
        subject.opsworks_config.should have_key(:app_id)
      end
    end

    context "#configure_aws!" do
      it "should load the config into the AWS module" do
        AWS.should_receive(:config).with(hash_including(access_key_id: 'key', secret_access_key: 'secret'))
        subject.configure_aws!
      end
    end
  end
end
