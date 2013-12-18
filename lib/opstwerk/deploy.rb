require 'aws-sdk'
require_relative 'client'

module Opstwerk
  class Deploy
    attr_reader :client

    def initialize(environment)
      @client = Client.new(environment)
    end

    def execute
      client.run_command('deploy')
    end
  end
end
