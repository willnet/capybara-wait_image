# frozen_string_literal: true

require "sinatra"
require "securerandom"

class App < Sinatra::Base
  @events = {}
  @events_mutex = Mutex.new

  class << self
    def reset_events!
      @events_mutex.synchronize { @events = {} }
    end

    def events
      @events_mutex.synchronize { @events.dup }
    end

    def record_event(name)
      @events_mutex.synchronize do
        @events[name] = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      end
    end
  end

  get "/next" do
    App.record_event(:next_requested_at)
    "<html><body><h1>Next Page</h1></body></html>"
  end

  get "/hovered" do
    App.record_event(:hover_requested_at)
    status 204
  end

  get "/with_a_image" do
    erb :with_a_image
  end

  get "/without_images" do
    %(<html><body><a href='/next'>Next Page</a></body></html>)
  end

  get "/heavy_image/*.png" do
    App.record_event(:image_requested_at)
    sleep 2
    App.record_event(:image_finished_at)
    content_type "image/png"
    File.binread("spec/heavy_image.png")
  end

  run! if app_file == $PROGRAM_NAME
end
