require 'opsicle/client'
require 'opsicle/deploy_monitor'


module Opsicle
  class Deployments
    attr_reader :client

    def initialize(environment)
      @client = Client.new(environment)
    end

    def execute(options={})
      DeployMonitor.new(@client).start
    end
  end
end
