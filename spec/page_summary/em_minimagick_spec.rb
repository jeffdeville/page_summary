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
  #context "when finding image urls " do
  #  let(:url) {"http://www.thinkgeek.com/images/products/frontsquare/prefectionist.jpg" }
  #
  #  xit ""
  #end
end
