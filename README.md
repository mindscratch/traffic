traffic [![Build Status](https://secure.travis-ci.org/mindscratch/traffic.png)](http://travis-ci.org/mindscratch/traffic)
=======
 
Count traffic incidents for a given area.

The initial implementation provides support for the Bing Traffic Incidents service.

Usage
-----

To get started, you first need to get an [API key](http://msdn.microsoft.com/en-us/library/ff428642.aspx) to access the Bing services.

Traffic Incidents API: http://msdn.microsoft.com/en-us/library/hh441726.aspx

```ruby
fetcher = Traffic::Fetchers::BingTrafficIncidents.new(
  /bounding_box/ => '39.202,-76.782,39.461,-76.467',
  /api_key/ => '',
  /severities/ => '4'
)

fetcher.fetch

puts fetcher.message   #=> "Request Succeeded"
puts fetcher.data      #=> {"moderate" => 6, "minor" => 1}
```
