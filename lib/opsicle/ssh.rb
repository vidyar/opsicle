require 'aws-sdk'
require_relative 'client'

module Opsicle
  class SSH
    attr_reader :client

    def initialize(environment)
      @client = Client.new(environment)
    end

    def execute
      say "Choose an Opsworks instance: \n"
      instances.each_index do |x|
        say "#{x+1}) #{instances[x][:hostname]}"
      end
      choice = ask("? ", Integer) { |q| q.in = 1..instances.length }

      instance_elastic_ip = instances[choice-1][:elastic_ip]

      system("ssh #{ssh_username}@#{instance_elastic_ip}")
    end

    def instances
      client.api_call(:describe_instances, { stack_id: client.config.opsworks_config[:stack_id] })
        .data[:instances]
    end

    def ssh_username
      client.api_call(:describe_my_user_profile)[:user_profile][:ssh_username]
    end
  end
end
