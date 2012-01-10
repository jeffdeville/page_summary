require 'spec_helper'
include PageSummary

describe EmMiniMagick do
  around(:each) {|example| inside_vcr_and_synchrony(example) }
  context "when loading an image" do
    let(:url) {"http://www.thinkgeek.com/images/products/frontsquare/prefectionist.jpg"}

    it "should load the image" do
      image = EmMiniMagick.load_image url
      image.should_not be_nil
      image[:width].should == 300
    end
  end

  context "when the image url is not a valid URI" do
    let(:url) { "this is not a url" }
    it "should raise an HTTP404" do
      lambda { EmMiniMagick.load_image url }.should raise_error URI::InvalidURIError
    end
  end

  context "when trying to load an image that does not exist" do
    let(:url) { "http://www.amazon.com/jeffwashere.jpg" }
    it "raises a 404 exception" do
      lambda { EmMiniMagick.load_image url }.should raise_error PageSummary::HTTP404
    end
  end
end
