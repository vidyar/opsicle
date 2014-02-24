module Opsicle
  module Monitor
    module Translatable

      def t
        {
          program: "Opsicle Stack Monitor #{Opsicle::VERSION}",
          menu: {
            inactive: {
              workers: "Workers",
              queues: "qUeues",
              retries: "Retries",
              schedules: "Scheduled",
            },
            active: {
              workers: "WORKERS",
              queues: "QUEUES",
              retries: "RETRIES",
              schedules: "SCHEDULED",
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
            worker: "WORKER",
            queue: "QUEUE",
            class: "CLASS",
            args: "ARGUMENTS",
            started_at: "STARTED",
            size: "SIZE",
            next_at: "NEXT",
            count: "COUNT",
            error: "ERROR",
            scheduled_at: "SCHEDULED",
          }
        }
      end
    end
  end
end
