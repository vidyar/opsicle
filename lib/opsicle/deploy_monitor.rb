require 'curses'
include Curses

module Opsicle
  class DeployMonitor
    def initialize(client)
      @client = client
    end

    def execute(deployment_id=nil)
      puts 'execute called'
    end
  end
end
