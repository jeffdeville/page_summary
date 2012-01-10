require 'spec_helper'
require 'vcr_setup'
require 'synchrony_rspec'
include PageSummary

describe EmMechanize do
  context "when loading the html for a page" do
    around(:each) do |example|
      VCR.use_cassette("em_http") do
        EM.synchrony do
          example.run
          EM.stop
        end
      end
    end
    
    let(:url) { "http://www.thinkgeek.com/tshirts-apparel/unisex/generic/894a/"}
    it "loads the url, and converts the response into a MachanizePage" do
      page = EmMechanize.load_url url
      page.title.should == " \t\t\t    ThinkGeek :: Prefectionist \t" # this should be the raw, not processed title
    end
  end
end
