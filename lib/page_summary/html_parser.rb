class HtmlParser
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def mech_page
    @page ||= EmMechanize.load_url(@url)
  end

  #def parse(url)
  #  # parse the title
  #  # iterate through the images, passing them to the image parser.
  #  # Is this image parser just a class method? there's nothing to new up, I don't think
  #  # so it seems like I could just do it that way.
  #  EmMiniMagick.find_images(mech_page.images.collect(&:url))
  #  #PageDetails.new({title: parse_title(page), body: parse_body(page)})
  #end

  def title
    mech_page.title.gsub(/^(\s)*/, "").gsub(/(\s)*$/, "")
  end

  def parse_body
    ""
  end
end
