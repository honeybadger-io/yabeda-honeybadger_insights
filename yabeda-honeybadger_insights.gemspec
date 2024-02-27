# frozen_string_literal: true

require_relative "lib/yabeda/honeybadger_insights/version"

Gem::Specification.new do |spec|
  spec.name = "yabeda-honeybadger_insights"
  spec.version = Yabeda::HoneybadgerInsights::VERSION
  spec.authors = ["Benjamin Curtis"]
  spec.email = ["ben@bencurtis.com"]

  spec.summary = "Yabeda Honeybadger Insights adapter"
  spec.homepage = "https://github.com/honeybadger-io/yabeda-honeybadger_insights"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/honeybadger-io/yabeda-honeybadger_insights"
  spec.metadata["changelog_uri"] = "https://github.com/honeybadger-io/yabeda-honeybadger_insights/blob/master/CHANGELOG.md"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_dependency "honeybadger", ">= 5.5"
  spec.add_dependency "yabeda", "~> 0.12"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
