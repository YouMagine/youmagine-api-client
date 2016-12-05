module Youmagine
  class Configuration
    attr_accessor :token, :uri
  end

  class << self
    attr_reader :configuration

    def configure(&_block)
      @configuration ||= Configuration.new
      yield @configuration
    end
  end
end
