module Opsicle
  module Monitor
    module Panels
      class Deployments < Monitor::Panel

        def initialize(height, width, top, left)
          super(height, width, top, left, structure(height), :divider_r => " ")

          # Include deployment abstraction here?
        end

        def structure(height)
          # [
          #   [relative_column_width, data_left, data_right]
          # ]
          s = [
            [ # table header slots
              [1, t[:heading][:status], nil],
              [1, t[:heading][:started_at], nil],
              [1, t[:heading][:finished_at], nil],
              [1, t[:heading][:user], nil],
              [1, t[:heading][:command], nil],
              [1, t[:heading][:app], nil],
            ],
          ]

          (0...(height - 1)).each do |i|
            s << [ # table row slots
              [1, -> { "status" },  nil],
              [1, -> { "startedat" },  nil],
              [1, -> { "finishedat" },  nil],
              [1, -> { "user" }, nil],
              [1, -> { "command" }, nil],
              [1, -> { "app" },  nil],
            ]
          end

          s
        end

      end
    end
  end
end
