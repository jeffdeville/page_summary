require 'vcr'

VCR.config do |c|
  c.stub_with :webmock
  c.default_cassette_options = {record: :new_episodes}
  c.cassette_library_dir="spec/cassettes"
end
