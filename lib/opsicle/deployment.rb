require 'aws-sdk'

module Opsicle
  class Deployment

    def initialize(deployment_id, client)
      @deployment_id = deployment_id
      @client = client
    end

    def deployment(options={})
      # Only call the API again if you need to
      @deployment = nil if options[:reload]
      @deployment ||= @client.api_call('describe_deployments',
                                       :deployment_ids => [@deployment_id]
                                      )[:deployments].first
    end
    private :deployment

    def deployment_id
      deployment[:deployment_id]
    end

    def stack_id
      deployment[:stack_id]
    end

    def app_id
      deployment[:app_id]
    end

    def created_at
      deployment[:created_at]
    end

    def completed_at
      deployment(reload: true)[:completed_at]
    end

    def duration
      deployment(reload: true)[:duration]
    end

    def command
      deployment[:command]
    end

    def status
      deployment(reload: true)[:status]
    end

    def instance_ids
      deployment[:instance_ids]
    end

    def running?
      status == 'running'
    end

    def successful?
      status == 'successful'
    end

    def failed?
      status == 'failed'
    end

  end
end
