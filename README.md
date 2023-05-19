# Capybara::WaitImage

The main cause of flaky tests in E2E tests using a browser is a click error caused by an element being out of alignment with the timing of image display.

By adding this gem, the test will wait for the image to be displayed just before each click, hover, etc, thus improving the reliability of the test.

Currently, this gem supports only RSpec, so if you want to use it for other than RSpec, please submit a pull request.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add capybara-wait_image --group=test

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/willnet/capybara-wait_image. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/willnet/capybara-wait_image/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Capybara::WaitImage project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/willnet/capybara-wait_image/blob/main/CODE_OF_CONDUCT.md).
