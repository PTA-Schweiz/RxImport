# Rximport

A flexible Excel parser based on Creek. Allows to create mappings and easily create
hash representations of excel data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rximport'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rximport

## Usage

### Create a Mapping
Mappings are used to convert excel rows into a hash representation

```ruby
class ProductMapping < Rximport
  map_attribute 'A', :pn
  map_attribute 'B', :name
  map_attribute 'C', :long_description
  map_attribute 'D', :price, :convert_price

  map_hash %i[K L M N O P Q R S T U V], :specs
  
  def convert_street_price(value, _column, _attr_key)
    return nil unless value.is_a? Numeric
    value
  end
end
```

Next we need to create a parser:
```ruby
parser = Rximport::Parser.new File.open("spec/fixtures/demodata.xlsx", parser_config)
```

Now we can iterate over mapped rows:
```ruby
products = parser.mapped_rows(ProductMapping.new)
products.first
=> {:pn=>"2RR73EA", :name=>"ProBook 470 G5", :long_description=>"Intel Core i5-8250U (QC)...", :price=>nil, :specs=>{"Processor"=>"Intel Core i5-8250U (QC)", "Graphics"=>"Nvidia GeForce 930MX 2GB", "Resolution"=>"FHD IPS 220 nits", "Size"=>"17.3\"", "RAM"=>"8GB", "Storage"=>"256GB SSD PCIe", "WLAN"=>"WLAN AC + BT 4.2", "OS"=>"Win 10 Pro", "Warranty"=>"2/2/0"}}
```

### Load remote excel files
Its possible to load excel files from a remote location. Not that this will download the file on initialization.

```ruby
parser = Parser.new("https://www.my-url.ch/data/product_sheets.xlsx", remote: true)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stestaub/rximport.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
