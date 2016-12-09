require_relative "../api_model"

module Youmagine
  class Design < ApiModel
    accept_attributes :name, :primary_image
    attr_reader :image

    def primary_image=(primary_image_data)
      @image = self.class.process_image_data(primary_image_data)
    end

    def documents
      @documents ||= Document.all(design_id: id)
    end

    def printable_documents
      documents.select(&:printable?)
    end

    def self.all(page: 1, limit: nil)
      limit ||= default_per_page
      options = { query: { page: page, limit: limit } }
      multiple_from_json_response(get("/designs", options))
    end

    def self.search(q:, page: 1, limit: nil)
      limit ||= default_per_page
      options = { query: { page: page, limit: limit, q: q } }
      multiple_from_json_response(get("/designs/search", options))
    end

    def self.find(design_id)
      from_json_response(get("/designs/#{design_id}"))
    end
  end
end
