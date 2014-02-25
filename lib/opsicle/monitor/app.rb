# Credit where credit is due:
# The Monitor module's architecture and many of its classes are heavily based on
# the work of tiredpixel's sidekiq-spy gem: https://github.com/tiredpixel/sidekiq-spy
# His help in working with the Ruby curses library has been invaluable - thanks tiredpixel!

require 'opsicle/client'

module Opsicle
  module Monitor
    class App

      attr_reader :running
      attr_reader :restarting

      class << self
        attr_accessor :client
      end

      def initialize(environment, options)
        @running    = false
        @restarting = false
        @threads    = {}

        # Make client with correct configuration available to monitor spies
        App.client = Client.new(environment)
      end

      def start
        begin
          @running = true

          setup

          @threads[:command] ||= Thread.new do
            command_loop # listen for commands
          end

          @threads[:refresh_screen] ||= Thread.new do
            refresh_screen_loop # refresh frequently
          end

          @threads[:refresh_data] ||= Thread.new do
            refresh_data_loop # refresh not so frequently
          end

          @threads.each { |tname, t| t.join }
        ensure
          cleanup
        end
      end

      def stop
        @running = false

        wakey_wakey # for Ctrl+C route; #do_command route already wakes threads
      end

      def restart
        @restarting = true
      end

      def do_command(key)
        case key
        when 'q' # Q is very natural for Quit; Queues comes second to this
          stop
        when 'd'
          @screen.panel_main = :deployments
        end

        wakey_wakey # wake threads for immediate response
      end

      private

      # def configure_sidekiq
      #   Sidekiq.configure_client do |sidekiq_config|
      #     sidekiq_config.logger = nil
      #     sidekiq_config.redis = {
      #       :url       => config.url,
      #       :namespace => config.namespace,
      #     }
      #   end
      # end

      def setup
        @screen = Monitor::Screen.new
      end

      def cleanup
        @screen.close if @screen
      end

      def wakey_wakey
        @threads.each { |tname, t| t.run if t.status == 'sleep' }
      end

      def command_loop
        while @running do
          next unless @screen # #refresh_loop might be reattaching screen

          key = @screen.next_key

          next unless key # keep listening if timeout

          do_command(key)
        end
      end

      def refresh_screen_loop
        while @running do
          next unless @screen # HACK: only certain test scenarios?

          if @restarting || @screen.missized? # signal(s) or whilst still resizing
            panel_main = @screen.panel_main

            cleanup

            setup

            @screen.panel_main = panel_main

            @restarting = false
          end

          @screen.refresh

          sleep 1 # go to sleep; could be rudely awoken on quit
        end
      end

      # This loop is specifically separate from the screen loop
      # because we don't want to spam OpWorks with API calls every second.
      def refresh_data_loop
        while @running do
          next unless @screen # HACK: only certain test scenarios?

          @screen.refresh_spies

          sleep 10
        end
      end
    end
  end
end
