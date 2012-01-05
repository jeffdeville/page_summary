require 'spec_helper'
require 'vcr_setup'
require 'synchrony_rspec'

describe HtmlParser do
  context "when loading up a url" do
    around(:each) do |example|
      VCR.use_cassette("page_summary") do
        EM.synchrony do
          example.run
          EM.stop
        end
      end
    end

    let(:url) { "http://www.thinkgeek.com/tshirts-apparel/unisex/generic/894a/" }

    it "should load the title into the page content" do
      parser = HtmlParser.new(url)
      parser.title.should == "ThinkGeek :: Prefectionist"
    end

    it "should load the images" do
      parser = HtmlParser.new(url)
      images = []
      parser.potential_images do |img_result|
        images << img_result
      end
      images.length.should == 5
    end
  end
end