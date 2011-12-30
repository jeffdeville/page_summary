require 'vcr'

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir="spec/cassettes"
end
