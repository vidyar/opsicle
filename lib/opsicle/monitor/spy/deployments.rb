require 'opsicle/deployments'

module Opsicle
  module Monitor
    module Spy
      class Deployments

        include Spy::Dataspyable

        def initialize
          @deployments = Opsicle::Deployments.new(App.client)
          refresh
        end

        def refresh
          h = []

          @deployments.data.each do |deployment|
            # Massage the API data for our uses
            h << {
              :deployment_id => deployment[:deployment_id],
              :stack_id      => deployment[:stack_id],
              :app_id        => deployment[:app_id],
              :created_at    => deployment[:created_at],
              :completed_at  => deployment[:completed_at],
              :duration      => deployment[:duration],
              :iam_user_arn  => deployment[:iam_user_arn],
              :comment       => deployment[:comment],
              :command       => deployment[:command][:name],
              :name          => deployment[:name],
              :args          => deployment[:args],
              :value         => deployment[:value],
              :status        => deployment[:status],
              :custom_json   => deployment[:custom_json],
              :instance_ids  => deployment[:instance_ids]
            }
          end

          @data = h
        end

      end
    end
  end
end
