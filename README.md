## Installation

Add this line to your application's Gemfile:

```ruby
gem 'webserver_log_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install webserver_log_parser

## Usage

run from command line:

`thor webages_visits_stats:parse_logs 'webserver.log'`

to count visits from unique addresses:

`thor webages_visits_stats:parse_logs 'webserver.log' -u`

or:

`thor webages_visits_stats:parse_logs 'webserver.log' --unique`

more info:

`thor help webages_visits_stats:parse_logs`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kamilsluszniak/webserver_log_parser.

