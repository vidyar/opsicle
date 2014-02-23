require 'aws-sdk'
require 'opsicle/client'



module Opsicle
  class Deployments
    attr_reader :client

    def initialize(environment)
      @client = Client.new(environment)
    end

    def execute(options={})
      puts "execute called"
    end
  end
end
