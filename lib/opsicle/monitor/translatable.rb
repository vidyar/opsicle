module Opsicle
  module Monitor
    module Translatable

      def t
        {
          program: "Opsicle Stack Monitor v#{Opsicle::VERSION}",
          menu: {
            inactive: {
              deployments: "(d)eployments",
              instances: "(i)nstances",
              apps: "(a)pps"
            },
            active: {
              deployments: "DEPLOYMENTS",
              instances: "INSTANCES",
              apps: "APPS"
            },
          },
          heading: {
            status: "STATUS",
            created_at: "STARTED",
            completed_at: "COMPLETED",
            user: "USER",
            command: "COMMAND"
          }
        }
      end
    end
  end
end
