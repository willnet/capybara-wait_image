# frozen_string_literal: true

require "sinatra"
require "securerandom"

class App < Sinatra::Base
  get "/next" do
    "<html><body><h1>Next Page</h1></body></html>"
  end

  get "/with_a_image" do
    erb :with_a_image
  end

  get "/without_images" do
    %(<html><body><a href='/next'>Next Page</a></body></html>)
  end

  get "/heavy_image/*.png" do
    sleep 2
    send_file("spec/heavy_image.png")
  end

  run! if app_file == $PROGRAM_NAME
end
