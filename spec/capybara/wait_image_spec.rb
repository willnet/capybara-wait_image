# frozen_string_literal: true

RSpec.describe Capybara::WaitImage, type: :feature do
  before do
    App.reset_events!
  end

  it "wait a image before click" do
    visit "/with_a_image"
    wait_until_event(:image_requested_at)
    expect(App.events).not_to have_key(:image_finished_at)

    click_link "Next Page"
    expect(page).to have_css("h1", text: "Next Page")

    expect(App.events.fetch(:next_requested_at)).to be >= App.events.fetch(:image_finished_at)
  end

  it "wait a image before hover" do
    visit "/with_a_image"
    wait_until_event(:image_requested_at)
    expect(App.events).not_to have_key(:image_finished_at)

    find_link("Next Page").hover

    wait_until_event(:hover_requested_at)
    expect(App.events.fetch(:hover_requested_at)).to be >= App.events.fetch(:image_finished_at)
  end

  def wait_until_event(name)
    Timeout.timeout(Capybara.default_max_wait_time) do
      sleep 0.01 until App.events.key?(name)
    end
  end
end
