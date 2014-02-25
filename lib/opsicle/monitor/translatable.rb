module Opsicle
  module Monitor
    module Translatable

      def t
        {
          program: "Opsicle Stack Monitor #{Opsicle::VERSION}",
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
            created_at: "STARTED AT",
            finished_at: "FINISHED AT",
            user: "USER",
            command: "COMMAND",
            app_id: "APP ID",
            instances: "INSTANCES"
          }
        }
      end
    end
  end
end
