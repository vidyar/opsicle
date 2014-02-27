require "spec_helper"
require "opsicle/monitor/app"
require "opsicle/monitor/screen"

def start_and_stop_app(app)
  app_thread = Thread.new { app.start }

  sleep 1 # patience, patience; give app time to start

  app.stop

  app_thread.join(2)

  Thread.kill(app_thread)
end


describe Opsicle::Monitor::App do

  before do
    @screen = double(
      :close     => nil,
      :refresh   => nil,
      :next_key  => nil,
      :refresh_spies => nil,
      :missized? => nil
    )

    @client = double

    allow(Opsicle::Monitor::Screen).to receive(:new).and_return(@screen)
    allow(Opsicle::Client).to receive(:new).and_return(@client)

    @app = Opsicle::Monitor::App.new("staging", {})
  end

  it "sets status not-running" do
    expect(@app.running).to equal(false)
  end

  it "sets status not-restarting" do
    expect(@app.restarting).to equal(false)
  end

  describe "#start" do

    it "sets status running within 1s" do
      thread_app = Thread.new { @app.start }

      sleep 1 # patience, patience; give app time to start

      expect(@app.running).to equal(true)

      Thread.kill(thread_app)
    end

    it "stops running within 1s" do
      thread_app = Thread.new { @app.start }

      sleep 1 # patience, patience; give app time to start

      @app.stop; t0 = Time.now

      thread_app.join(2)

      Thread.kill(thread_app)

      expect(Time.now - t0).to be <= 1
    end

    it "calls #setup hook" do
      expect(@app).to receive(:setup)

      start_and_stop_app(@app)
    end

    it "calls #refresh on screen" do
      expect(@screen).to receive(:refresh)

      start_and_stop_app(@app)
    end

    it "calls #refresh_spies on screen" do
      expect(@screen).to receive(:refresh_spies)

      start_and_stop_app(@app)
    end

    it "calls #cleanup hook" do
      expect(@app).to receive(:cleanup)

      start_and_stop_app(@app)
    end
  end

  describe "#stop" do
    before do
      @app.instance_variable_set(:@running, true)
    end

    it "sets status not-running" do
      @app.stop

      expect(@app.running).to equal(false)
    end
  end

  describe "#restart" do
    before do
      @app.instance_variable_set(:@restarting, false)
    end

    it "sets status restarting" do
      @app.restart

      expect(@app.restarting).to equal(true)
    end
  end

  describe "#do_command" do
    before do
      @app.instance_variable_set(:@running, true)
      @app.instance_variable_set(:@screen, @screen)
    end

    it "<q> sets status not-running" do
      @app.do_command('q')

      expect(@app.running).to equal(false)
    end

    it "<d> switches to Deployments panel" do
      expect(@screen).to receive(:panel_main=).with(:deployments)

      @app.do_command('d')
    end

    it "<h> switches to Help panel" do
      expect(@screen).to receive(:panel_main=).with(:help)

      @app.do_command('h')
    end
  end

end
