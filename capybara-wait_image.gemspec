# frozen_string_literal: true

require_relative "lib/capybara/wait_image/version"

Gem::Specification.new do |spec|
  spec.name = "capybara-wait_image"
  spec.version = Capybara::WaitImage::VERSION
  spec.authors = ["willnet"]
  spec.email = ["netwillnet@gmail.com"]

  spec.summary = "Reduce click miss in E2E tests and increases test stability"
  spec.description = "Reduce click miss in E2E tests and increases test stability due to waiting for image to load automatically"
  spec.homepage = "https://github.com/willnet/capybara-wait_image"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/willnet/capybara-wait_image"
  spec.metadata["changelog_uri"] = "https://github.com/willnet/capybara-wait_image/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara", "~> 3.0"
end
