module Opstwerk
  class Client
    def initialize(environment)
      @config = Config.new(environment)
      @config.configure_aws!
      AWS::OpsWorks.new.client
    end
  end
end
