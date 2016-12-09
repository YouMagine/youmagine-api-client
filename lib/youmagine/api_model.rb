require "HTTParty"
require_relative "paginated_collection"

module Youmagine
  class ApiModel
    ACCEPTED_IMAGE_VERSIONS = %i(small medium large).freeze
    DEFAULT_ACCEPTED_ATTRIBUTES = %i(id).freeze

    def self.default_per_page
      18
    end

    def self.accept_attributes(*attributes)
      @accepted_attributes = DEFAULT_ACCEPTED_ATTRIBUTES + attributes
      attr_accessor(*@accepted_attributes)
    end

    def self.multiple_from_json_response(response)
      data = JSON.parse(response.body, symbolize_names: true)

      records = data.map do |model_json|
        new(model_json.select { |k| @accepted_attributes.include?(k) })
      end

      PaginatedCollection.new(records, response.headers)
    end

    def self.from_json_response(response)
      new(JSON.parse(response.body, symbolize_names: true).select { |k| @accepted_attributes.include?(k) })
    end

    def self.process_image_data(image_data)
      image = ACCEPTED_IMAGE_VERSIONS.map do |image_version|
        [image_version, image_data.dig(:file, image_version, :url)]
      end.to_h

      image[:original] = image_data.dig(:file, :url)
      image
    end

    def self.get(path, options = { })
      uri = Youmagine.configuration.uri + path

      options[:query] ||= {}
      options[:query][:auth_token] = Youmagine.configuration.token

      begin
        HTTParty.get(uri, options)
      rescue
        raise Youmagine::ConnectionException, "Host is down"
      end
    end

    def initialize(attributes = {})
      attributes.each do |key, value|
        public_send("#{key}=", value)
      end
    end
  end
end

