# frozen_string_literal: true

require_relative "wait_image/version"
require "capybara"

module Capybara
  # Wait for image to load automatically
  module WaitImage
    def _stale_errors
      return @_stale_errors if defined? @_stale_errors

      @_stale_errors = []
      if defined? ::Selenium::WebDriver::Error::StaleElementReferenceError
        @_stale_errors << ::Selenium::WebDriver::Error::StaleElementReferenceError
      end
      @_stale_errors << ::Ferrum::NodeNotFoundError if defined? ::Ferrum::NodeNotFoundError
      @_stale_errors << ::Capybara::Cuprite::ObsoleteNode if defined? ::Capybara::Cuprite::ObsoleteNode
      @_stale_errors
    end

    def _wait_for_image_loading # rubocop:disable Metrics/MethodLength
      Timeout.timeout(Capybara.default_max_wait_time) do
        sleep 0.5 until evaluate_script(<<~JS)
          Array.prototype.every.call(
            document.querySelectorAll('img'),
            (e) => e.complete
          )
        JS
      end
    rescue Timeout::Error
      _logger.debug "[capybara-wait_image]Timeout::Error"
    rescue Capybara::NotSupportedByDriverError
      # It comes here when you run it in rack-test, but you can ignore it
    rescue *_stale_errors
      _logger.debug "[capybara-wait_image]Stale Error"
      reload
      _wait_for_image_loading
    end

    def click(*keys, **options)
      _wait_for_image_loading
      super
    end

    def hover
      _wait_for_image_loading
      super
    end

    def _logger
      @_logger ||= if defined?(Rails)
                     Rails.logger
                   else
                     Logger.new("/dev/null")
                   end
    end
  end

  module Node
    class Element < Base
      prepend WaitImage
    end
  end
end
