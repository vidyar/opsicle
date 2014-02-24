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
              [2, "heading1", nil],
              [1, "heading2", nil],
              [1, "heading3", nil],
              [1, "heading4", nil],
              [1, nil,                  t[:heading][:started_at]],
            ],
          ]

          (0...(height - 1)).each do |i|
            s << [ # table row slots
              [2, -> { "something1" },  nil],
              [1, -> { "something2" }, nil],
              [1, -> { "something3" }, nil],
              [1, -> { "something4" },  nil],
              [1, nil,                                -> { "started at" }],
            ]
          end

          s
        end

      end
    end
  end
end
