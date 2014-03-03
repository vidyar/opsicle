module Opsicle
  class Deploy
    attr_reader :client

    def initialize(environment)
      @environment = environment
      @client = Client.new(environment)
    end

    def execute(options={})
      response = client.run_command('deploy')

      if options[:browser]
        open_deploy(response[:deployment_id])
      else
        @monitor = Opsicle::Monitor::App.new(@environment, options)

        begin
          @monitor.start
        rescue => e
          say "<%= color('Uh oh, an error occurred while starting the Opsicle Stack Monitor.', RED) %>"
          say "<%= color('Use --trace to view stack trace.', RED) %>"

          if options.trace
            raise
          end
        end
      end
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
