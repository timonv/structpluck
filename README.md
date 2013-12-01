# Structpluck

<img src=https://travis-ci.org/timonv/structpluck.png></img>

A very simple gem that allows you to pluck to structs instead of ugly multidimensional arrays. Still very fast, but at least you'll get a rigid data type. :-)

## Installation

Add this line to your application's Gemfile:

    gem 'structpluck'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install structpluck

## Usage

Include it in your active record class and then:

```ruby
YourClass.where(query).struct_pluck(*column_names) # => SO MANY STRUCTS
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
