# AkamaiTools

Akamai Tools provide some helpful tools:

* Akamai CCP Purge invalidation / deletions
* Akamai Net Storage upload

The benefit of this are:

* SFTP support, the most other gems supporting only FTP
* Less dependencies, we use Net::HTTP and don't need a separate HTTP gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'akamai_tools'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install akamai_tools

## General

### Logger

Akamai Tools has a build in logger, you can disable him by:

```ruby
Akamai.logging = false
```

### Configuration

You can configure each property in three different ways.

#### Global

```ruby
Akamai::MODULE.configure do |config|
  config.user     = "user"
end
```

#### Per instance as options

```ruby
Akamai::MODULE.new(user: "user")
```

#### Per instance accessor

```ruby
module = Akamai::MODULE.new
module.user = "user"
```

You can combine all tree ways, too.

## Akamai CCP Purge

### Configuration

```ruby
Akamai::Purge.configure do |config|
  config.host     = "http://your_content.akamaihd.net"
  config.user     = "user"
  config.password = "password"
end
```

### Usage

```ruby
# remove one file
Akamai::Purge.new.remove "foo/bar"

# remove multi files
Akamai::Purge.new.remove ["foo/bar", "bar/foo"]

# invalidate one file
Akamai::Purge.new.invalidate "foo/bar"

# invalidate multi files
Akamai::Purge.new.invalidate ["foo/bar", "bar/foo"]
```

## Akamai Net Storage

### Configuration

```ruby
Akamai::Upload.configure do |config|
  config.host               = "your_content.upload.akamai.com"
  config.user               = "user"
  config.connection_options = {} # will be pass to Net::SFTP
  config.source_root        = "/var/www/app/public"
  config.destination_root   = "12345"
end
```

### Usage

```ruby
upload = Akamai::Upload.new
upload.session do |session|
  session.upload("file")
end
```

## Road Map

* Support for Net Storage sync
* Support for Net Storage delete
* Storage for external Logger

## Contributing

1. Fork it ( https://github.com/Zoom7/akamai_tools/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
