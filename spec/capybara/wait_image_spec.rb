# frozen_string_literal: true

RSpec.describe Capybara::WaitImage, type: :feature do
  it "wait a image before click" do
    visit "/without_images"
    without_images_before = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    click_link "Next Page"
    without_images_after = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    expect(page).to have_css("h1", text: "Next Page")

    visit "/with_a_image"
    with_a_image_before = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    click_link "Next Page"
    with_a_image_after = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    expect(page).to have_css("h1", text: "Next Page")

    without_images_duration = without_images_after - without_images_before
    with_a_image_duration = with_a_image_after - with_a_image_before

    expect(without_images_duration + 2).to be_within(0.5).of(with_a_image_duration)
  end

  it "wait a image before hover" do
    visit "/without_images"
    without_images_before = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    find_link("Next Page").hover
    without_images_after = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    visit "/with_a_image"
    with_a_image_before = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    find_link("Next Page").hover
    with_a_image_after = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    without_images_duration = without_images_after - without_images_before
    with_a_image_duration = with_a_image_after - with_a_image_before

    expect(without_images_duration + 2).to be_within(0.5).of(with_a_image_duration)
  end
end
