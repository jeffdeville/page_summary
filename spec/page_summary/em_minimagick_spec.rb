require 'spec_helper'
require 'vcr_setup'

describe EmMiniMagick do
  around(:each) {|example| inside_vcr_and_synchrony(example) }
  context "when loading an image" do
    #around(:each) do |example|
    #  VCR.use_cassette("em_http_image") do
    #    EM.synchrony do
    #      example.run
    #      EM.stop
    #    end
    #  end
    #end

    let(:url) {"http://www.thinkgeek.com/images/products/frontsquare/prefectionist.jpg"}

    it "should load the image" do
      image = EmMiniMagick.load_image url
      image.should_not be_nil
      image[:width].should == 300

    end
  end

  #context "when finding image urls " do
  #  let(:url) {"http://www.thinkgeek.com/images/products/frontsquare/prefectionist.jpg" }
  #
  #  xit ""
  #end
end
