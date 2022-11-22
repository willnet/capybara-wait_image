# frozen_string_literal: true

require_relative "wait_before_click/version"
require "capybara"

module Capybara
  module WaitBeforeClick
    def _wait_for_image_loading
      Timeout.timeout(Capybara.default_max_wait_time) do
        sleep 0.5 until evaluate_script(<<~JS)
        Array.prototype.every.call(
          document.querySelectorAll('img'),
          (e) => e.complete
        )
        JS
      end
    rescue Timeout::Error
      _logger.debug '[capybara-wait_before_click]Timeout::Error'
    rescue Capybara::NotSupportedByDriverError
      # It comes here when you run it in rack-test, but you can ignore it
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      _logger.debug '[capybara-wait_before_click]Selenium::WebDriver::Error::StaleElementReferenceError'
      reload
      _wait_for_image_loading
    end

    def click(*keys, **options)
      _wait_for_image_loading
      super
    end

    def _logger
      @_logger ||= if defined?(Rails)
                     Rails.logger
                   else
                     Logger.new('/dev/null')
                   end
      end
    end
  end

  module Node
    class Element < Base
      prepend WaitBeforeClick
    end
  end
end
