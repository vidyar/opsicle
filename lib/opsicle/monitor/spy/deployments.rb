require 'opsicle/deployments'

module Opsicle
  module Monitor
    module Spy
      class Deployments

        include Spy::Dataspyable

        def initialize
          @deployments = Opsicle::Deployments.new(::Opsicle::Monitor::App.client)
          refresh
        end

        def refresh
          h = []

          @deployments.data.each do |deployment|
            h << deployment
            #  each deployment gives the following from the AWS API:
            #  :deployment_id - (String)
            #  :stack_id - (String)
            #  :app_id - (String)
            #  :created_at - (String)
            #  :completed_at - (String)
            #  :duration - (Integer)
            #  :iam_user_arn - (String)
            #  :comment - (String)
            #  :command - (Hash)
            #  :name - (String)
            #  :args - (Hash<String,Hash>)
            #  :value - (Array)
            #  :status - (String)
            #  :custom_json - (String)
            #  :instance_ids - (Array)
          end

          @data = h
        end

      end
    end
  end
end
