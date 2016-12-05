require "HTTParty"
require_relative "paginated_collection"

module Youmagine
  class ApiModel
    include HTTParty

    base_uri Youmagine.configuration.uri
    default_params auth_token: Youmagine.configuration.token

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
        new(model_json.slice(*@accepted_attributes))
      end

      PaginatedCollection.new(records, response.headers)
    end

    def self.from_json_response(response)
      new(JSON.parse(response.body, symbolize_names: true).slice(*@accepted_attributes))
    end

    def self.process_image_data(image_data)
      image = ACCEPTED_IMAGE_VERSIONS.map do |image_version|
        [image_version, image_data.dig(:file, image_version, :url)]
      end.to_h

      image[:original] = image_data.dig(:file, :url)
      image
    end

    def initialize(attributes = {})
      attributes.each do |key, value|
        public_send("#{key}=", value)
      end
    end

    def get(uri, options)

    end
  end
end

