# Honeybadger Insights plugin for Yabeda

[![Tests](https://github.com/honeybadger-io/yabeda-honeybadger_insights/actions/workflows/test.yml/badge.svg)](https://github.com/honeybadger-io/yabeda-honeybadger_insights/actions/workflows/test.yml)
[![Gem Version](https://badge.fury.io/rb/yabeda-honeybadger_insights.svg)](https://rubygems.org/gems/yabeda-honeybadger_insights)

This [Yabeda] adapter sends application metrics to [Honeybadger Insights].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yabeda-honeybadger_insights'
```

And then execute:

```shell
bundle
```

## Usage

Register the adapter along with your other Yabeda initialization code (such as in `config/initializers/yabeda.rb`).

```ruby
Yabeda.configure do
  register_adapter(:honeybadger_insights, Yabeda::HoneybadgerInsights::Adapter.new)
end
```

All metrics will be sent to Honeybadger Insights as events, so counters, gauges, and histograms are all treated the same way.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/honeybadger-io/yabeda-honeybadger_insights).

### To contribute your code:

1. Fork the repo.
2. Create a topic branch `git checkout -b my_branch`.
3. Make your changes and add an entry to the [CHANGELOG](CHANGELOG.md).
4. Commit your changes `git commit -am "Boom"`
5. Push to your branch `git push origin my_branch`
6. Send a [pull request](https://github.com/honeybadger-io/yabeda-honeybadger_insights/pulls)

### Releasing

Releases are automated using [GitHub Actions](.github/workflows/release.yml):

* When a PR is merged on main the [test.yml](.github/workflows/test.yml) workflow is executed to run the tests.
* If the tests pass, the [release.yml](.github/workflows/release.yml) workflow will be executed.
* Depending on the commit message, a release PR will be created with the suggested  version bump and changelog.
  Note: Not all commit messages trigger a new release. For example, `chore: ...` will not trigger a release.
* If the release PR is merged, the [release.yml](.github/workflows/release.yml) workflow will be executed again, and this time it will create a GitHub release, bundle the gem, and push it to RubyGems.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[Honeybadger Insights]: https://www.honeybadger.io/tour/insights/
[Yabeda]: https://github.com/yabeda-rb/yabeda