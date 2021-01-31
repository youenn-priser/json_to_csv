# JsonToCsv
## Installation

Add this line to your application's Gemfile:

install the gem yourself running this command in your terminal:

    $ gem install json_to_csv

## Usage
### From the console

    $ irb
    $ require 'json_to_csv'
    $ JsonToCsv::Convert.new('your_json_file_path')

This will convert your JSON into a CSV file, generated right in the directory from which your calling the method.

### From your ruby file
```ruby
require 'json_to_csv'

JsonToCsv::Convert.new('your_json_file_path')
```
This will convert your JSON into a CSV file, generated right in the directory from which your calling the method.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_to_csv.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
