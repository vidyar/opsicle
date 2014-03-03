module Opsicle
  class Deployments

    def initialize(client)
      @client = client
    end

    def data
      deployments(reload: true)
    end

    def deployments(options={})
      # Only call the API again if you need to
      @deployments = nil if options[:reload]
      @deployments ||= @client.api_call('describe_deployments',
                                       :stack_id => @client.config.opsworks_config[:stack_id]
                                      )[:deployments]
    end
    private :deployments

  end
end
