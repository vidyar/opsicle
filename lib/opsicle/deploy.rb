require 'aws-sdk'
require_relative 'client'

module Opsicle
  class Deploy
    attr_reader :client

    def initialize(environment)
      @client = Client.new(environment)
    end

    def execute
      response = client.run_command('deploy')
      open_deploy(response[:deployment_id])
    end

    def open_deploy(deployment_id)
      if deployment_id
        exec "open 'https://console.aws.amazon.com/opsworks/home?#/stack/#{client.config.opsworks_config[:stack_id]}/deployments'"
      else
        puts 'deploy failed'
      end
    end
  end
end
