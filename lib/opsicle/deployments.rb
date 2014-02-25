module Opsicle
  class Deployments

    def initialize(client)
      @client = client
    end

    def deployments(options={})
      # Only call the API again if you need to
      @deployments = nil if options[:reload]
      @deployment ||= @client.api_call('describe_deployments',
                                       :stack_id => @client.config.opsworks_config[:stack_id]
                                      )[:deployments].first
    end
    private :deployments

    def data
      deployments(reload: true)
    end

  end
end
