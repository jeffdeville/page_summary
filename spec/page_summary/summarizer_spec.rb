require 'spec_helper'
require 'vcr_setup'
require 'synchrony_rspec'
include PageSummary

describe Summarizer do
  around(:each) { |example| inside_vcr_and_synchrony example }
  subject { Summarizer.new(url) }

  context "when loading up a url" do
    let(:url) { "http://www.thinkgeek.com/tshirts-apparel/unisex/generic/894a/" }

    it "should load the title into the page content" do
      subject.title.should == "ThinkGeek :: Prefectionist"
    end

    it "should load the images" do
      images = []
      subject.potential_images{|img_result| images << img_result }
      images.should have(5).items
    end
  end

  context "when trying to load a bad url" do
    let(:url) { "I am not an url" }
    it "does not try to load the url, just sends an error message" do
      lambda { Summarizer.new(url) }.should raise_error URI::InvalidURIError
    end
  end

  context "when trying to load a url that does not exist" do
    let(:url) { "http://www.amazon.com/jeffwashere" }
    it "raises a 404 exception" do
      lambda { subject.mech_page }.should raise_error PageSummary::HTTP404
    end
  end

  context "when the page is 30x'd" do
    let(:url) { "http://www.jeffdeville.com/" }
    it "follows the redirect" do
      subject.mech_page.title.should == "Jeff Deville - Entrepreneurship, Ruby, .Net"
    end
  end

  context "when network errors prevent success" do
    let(:url) { "http://www.jeffdeville.com/" }
    let(:mock_request) { mock() }
    let(:mock_response_header) do
      m = mock()
      m.expects(:response_header).returns(EM::HttpResponseHeader.new).times(3)
      m 
    end
    before do
      EM::HttpRequest.expects(:new).returns(mock_request).times(3)
      mock_request.expects(:get).returns(mock_response_header).times(3)
    end

    it "raises an HTTPNetworkError" do
      lambda { subject.mech_page }.should raise_error PageSummary::HTTPNetworkError
    end
  end

end