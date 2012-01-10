# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "page_summary/version"

Gem::Specification.new do |s|
  s.name = "page_summary"
  s.version = PageSummary::VERSION
  s.authors = ["Jeff Deville"]
  s.email = ["jeffdeville@gmail.com"]
  s.homepage = "https://github.com/jeffdeville/page_summary"
  s.summary = %q{Configurable Rails engine that extracts page summaries of any url }
  s.description = %q{I am not sure what goes here, that was not in the summary}

  s.rubyforge_project = "page_summary"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency "em-websocket"
  s.add_dependency "em-synchrony"
  s.add_dependency "json"
  s.add_dependency "mechanize"
  s.add_dependency "em-http-request"
  s.add_dependency "mini_magick"
  s.add_dependency "goliath"

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "fuubar"
  s.add_development_dependency "bourne"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_development_dependency "awesome_print"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  if RUBY_PLATFORM =~ /darwin/i
    s.add_development_dependency 'rb-fsevent'
    s.add_development_dependency 'growl'
  end
end
