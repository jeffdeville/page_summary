module PageSummary
  class Summarizer
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
      urls = mech_page.images.collect(&:url).
              find_all { |img| not_throw_away_image?(img) }.uniq
      EM::Synchrony::Iterator.new(urls, 4).map do |url, iter|
        http_image = EM::HttpRequest.new(url).aget
        http_image.callback do
          result = product_image?(url, http_image)
          yield result if result
          iter.return
        end
      end
    end


    private
    def product_image?(image_url, image)
      img = ::MiniMagick::Image.read image.response
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
end