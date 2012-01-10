module EventMachineVcr
  def inside_vcr
    VCR.use_cassette("page_summary") do
      yield
    end
  end

  def inside_synchrony(example)
    EM.synchrony do
      example.run
      EM.stop
    end
  end

  def inside_vcr_and_synchrony(example)
    inside_vcr do
      inside_synchrony example
    end
  end
end

RSpec.configure do |config|
  config.mock_with :mocha
  config.include EventMachineVcr
end

