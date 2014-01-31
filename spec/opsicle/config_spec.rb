require "spec_helper"
require "opsicle/config"
module Opsicle
  describe Config do
    subject { Config.new('derp') }
    context "with a valid config" do
      before do
        File.stub(:exist?).with(File.expand_path '~/.fog').and_return(true)
        File.stub(:exist?).with('./.opsicle').and_return(true)
        YAML.stub(:load_file).with(File.expand_path '~/.fog').and_return({'derp' => { 'aws_access_key_id' => 'key', 'aws_secret_access_key' => 'secret'}})
        YAML.stub(:load_file).with('./.opsicle').and_return({'derp' => { 'app_id' => 'app', 'stack_id' => 'stack'}})
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

    context "missing configs" do
      before do
        File.stub(:exist?).with(File.expand_path '~/.fog').and_return(false)
        File.stub(:exist?).with('./.opsicle').and_return(false)
      end

      context "#aws_config" do
        it "should gracefully raise an exception if no .fog file was found" do
          expect {subject.aws_config}.to raise_exception
        end
      end

      context "#opsworks_config" do
        it "should gracefully raise an exception if no .fog file was found" do
          expect {subject.opsworks_config}.to raise_exception
        end
      end
    end
  end
end
