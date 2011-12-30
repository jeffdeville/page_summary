require 'spec_helper'
require 'vcr_setup'
require 'synchrony_rspec'

describe EmMechanize do
  context "when loading the html for a page" do
    p "in the context"
    around(:each) do |example|
      VCR.use_cassette("em_http") do
        EM.synchrony do
          p "in the synchorny block"
          example.run
          EM.stop
        end
      end
    end
    
    let(:url) { "http://www.thinkgeek.com/tshirts-apparel/unisex/generic/894a/"}
    it "loads the url, and converts the response into a MachanizePage" do
      p "about to load the url"
      page = EmMechanize.load_url url
      p "waiting for the result"
      page.title.should == " \t\t\t    ThinkGeek :: Prefectionist \t" # this should be the raw, not processed title
    end
  end
end
