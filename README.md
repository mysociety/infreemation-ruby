# Infreemation

A Ruby client library for the [Infreemation](http://www.digital-interactive.com/products/infreemation) API from [Digital Interactive](http://www.digital-interactive.com). Infreemation is a eCase management software system built specifically to manage FOI, EIR and SAR requests. Currently this library only supports FOI requests.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'infreemation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install infreemation

## Configuration

If you're using Rails, you can generate an initializer with the following
command:

``` ruby
Infreemation.logger = Logger.new(STDOUT)
Infreemation.url = ENV['INFREEMATION_URL']
Infreemation.api_key = ENV['INFREEMATION_API_KEY']
Infreemation.username = ENV['INFREEMATION_USERNAME']
```

## Usage

### Creating requests

```ruby
Infreemation::Request.create!(
  rt: 'create',
  type: 'FOI',
  requester: 'Fred Smith',
  contact: 'fred@hotmail.com',
  contacttype: 'email',
  subject: 'Missed Bins',
  category: 'Waste',
  body: 'Dear FOI team/nPlease treat this as a request under the FOI act etc'
)
```

### Retrieving published requests

```ruby
Infreemation::Request.where(
  rt: 'published',
  startdate: '2018-01-01',
  enddate: '2019-01-01'
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mysociety/infreemation-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Infreemation project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mysociety/infreemation-ruby/blob/master/CODE_OF_CONDUCT.md).
