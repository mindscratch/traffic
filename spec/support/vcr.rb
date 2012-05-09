require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixutres/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<API KEY>') { 'not-a-real-key'   }
end
