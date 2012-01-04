require 'spec_helper'
require 'vcr_setup'
require 'synchrony_rspec'

describe EmMiniMagick do
  context "when loading an image" do
    around(:each) do |example|
      VCR.use_cassette("em_http_image") do
        EM.synchrony do
          example.run
          EM.stop
        end
      end
    end

    let(:url) {"http://www.thinkgeek.com/images/products/frontsquare/prefectionist.jpg"}

    it "should load the image" do
      image = EmMiniMagick.load_image url
      image.should_not be_nil
      image[:width].should == 300

    end
  end
end
