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
          redis: {
            connection: "redis:",
            namespace: "namespace:",
            version: "redis version:",
            uptime: "uptime (d):",
            connections: "connections:",
            memory: "memory:",
            memory_peak: "memory peak:",
          },
          sidekiq: {
            busy: "busy:",
            retries: "retries:",
            processed: "processed:",
            enqueued: "enqueued:",
            scheduled: "scheduled:",
            failed: "failed:",
          },
          heading: {
            status: "STATUS",
            started_at: "STARTED",
            finished_at: "FINISHED",
            user: "USER",
            command: "COMMAND",
            app: "APP",
            instances: "INSTANCES"
          }
        }
      end
    end
  end
end
