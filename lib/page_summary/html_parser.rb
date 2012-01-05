class HtmlParser
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def mech_page
    @page ||= EmMechanize.load_url(@url)
  end

  def title
    mech_page.title.gsub(/^(\s)*/, "").gsub(/(\s)*$/, "")
  end

  def body
    ""
  end

  def potential_images
    mech_page.images.collect(&:url).
            find_all { |img| not_throw_away_image?(img) }.
            uniq.
            each do |image_url|
      result = product_image? image_url
      yield result if result
    end
  end


  private
  def product_image?(image_url)
    file = EM::HttpRequest.new(image_url).get
    img = ::MiniMagick::Image.read file.response
    width = img[:width]
    height = img[:height]
    ratio = width.to_f / height.to_f
    false unless 0.5625 <= ratio and ratio <= 1.77 # 16:9
    if width * height > 15000
      {:url => image_url, :width => width, :height => height}
    end
  end

  def not_throw_away_image?(img_url)
    !img_url.nil? || !/sprite/i.match(img_url) || !/pixel/i.match(img_url)
  end

end
