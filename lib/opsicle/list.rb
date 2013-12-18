require 'aws-sdk'
require 'terminal-table'
require_relative 'client'

module Opsicle
  class List
    attr_reader :client

    def initialize(environment)
      @client = Client.new(environment)
    end

    def execute
      stack_ids = get_stacks
      apps = get_apps(stack_ids)
      print(apps)
    end

    def get_stacks
      client.api_call('describe_stacks')[:stacks].map{|s| s[:stack_id] }
    end

    def get_apps(stack_ids)
      stack_ids.map{ |stack_id| apps_for_stack(stack_id) }.flatten
    end

    def apps_for_stack(stack_id)
      client.api_call('describe_apps', stack_id: stack_id)[:apps]
    end

    def print(apps)
      puts Terminal::Table.new :headings => ['Name', 'Stack Id', 'App Id'], rows: app_data(apps)
    end

    def app_data(apps)
      apps.map{|app| [app[:name], app[:stack_id], app[:app_id]] }
    end

  end
end
