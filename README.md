# Starling Ruby Library

The Starling Ruby library provides a simple, idiomatic interface to the [Starling Bank API](https://developer.starlingbank.com).

[![CircleCI](https://circleci.com/gh/timrogers/starling-ruby/tree/master.svg?style=svg)](https://circleci.com/gh/timrogers/starling-ruby/tree/master)
[![Gem Version](https://badge.fury.io/rb/starling-ruby.svg)](https://badge.fury.io/rb/starling-ruby)

## Getting started

Install the gem by adding it to your Gemfile, and then run `bundle`:

```ruby
gem 'starling-ruby', '~> 0.1.0'
```

You can now initialise the client, providing an access token, an optionally an
environment (either `:sandbox` or `:production`, defaulting to :production):

```ruby
starling = Starling::Client.new(
  access_token: ENV['STARLING_ACCESS_TOKEN'],
  # Omit the line below to use the default production environment
  environment: :sandbox,
)
```

## Usage

Once you've initialised a `Starling::Client`, it exposes a number of services (living
in `lib/starling/services`) which have methods calling out to the API, and returning
resources (found in `lib/starling/resources`).

Much of the API has not yet been implemented. Stay tuned for further updates ❤️

### Check your balance

```ruby
balance = starling.account_balance.get
puts "Your balance is #{balance.amount} #{balance.currency}!"
```

### Fetch information about your account

```ruby
account = starling.account.get
puts "Your sort code is #{account.sort_code} and your account number is " \
     "#{account.number}."
```

### List transactions

```ruby
transaction = starling.transactions.list.first
puts "Your most recent transaction was for #{transaction.amount} on " \
     "#{transaction.created}"
```

### Fetch a transaction by ID

```ruby
transaction = starling.transactions.get("insert-uuid-here")
puts "Your transaction was for #{transaction.amount} on #{transaction.created}"
```

### Fetch a merchant by ID

```ruby
merchant = starling.merchants.get("insert-uuid-here")
puts "You can call #{merchant.name} on #{merchant.phone_number}"
```

### Fetch a merchant location by ID

```ruby
merchant_location = starling.merchant_locations.get(
  "insert-merchant-uid-here",
  "insert-merchant-location-uid-here"
)

puts "This location for #{merchant_location.merchant_name} is called " \
     "#{merchant_location.location_name}"
```

## Backwards compatability

This gem is versioned using [Semantic Versioning](http://semver.org/), so you can be
confident when updating that there will not be breaking changes outside of a major
version (following format MAJOR.MINOR.PATCH, so for instance moving from 2.3.0 to 3.0.0
would be allowed to include incompatible API changes). See
[CHANGELOG.md](https://github.com/timrogers/starling-ruby/tree/master/CHANGELOG.md) for
details on what has changed in each version.

Until we reach v1.0, minor versions may contain backwards-incompatible changes, as the
API stabilises. Any such changes will be flagged in the changelog.

## Tests

The recommended way to run tests on the project is using CircleCI's local Docker
testing - this is the best way to make sure that what passes tests locally in development
will work when you push it and it runs through our automated CI.

```bash
# Download the circleci binary (assuming /usr/local/bin is in your PATH)
curl -o /usr/local/bin/circleci \
https://circle-downloads.s3.amazonaws.com/releases/build_agent_wrapper/circleci

chmod +x /usr/local/bin/circleci

# Run the full CI process, including tests, Rubocop and Reek. You'll need Docker
# installed.
circleci build
```

You can also run tests in your own environment by running `bundle exec rake`, can
run Rubocop by running `bundle exec rubocop` and can run Reek by running `bundle exec
reek lib`.

## Contributing

All contributions are welcome - just make a pull request, making sure you include tests
and documentation for any public methods, and write a good, informative commit
message/pull request body.

Check out
[CODE_OF_CONDUCT.md](https://github.com/timrogers/starling-ruby/blob/master/CODE_OF_CONDUCT.md)
to learn about how we can best work together as an open source community to make the
Starling Ruby library as good as it can be.