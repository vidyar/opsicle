require 'aws-sdk'
require_relative 'client'
require 'curses'
include Curses

module Opsicle
  class DeployMonitor
    attr_reader :client

    def initialize(environment)
      @client = Client.new(environment)
    end

    def execute(options={})
      puts "execute called"
    end
  end
end
