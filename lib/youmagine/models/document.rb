require_relative "../api_model"

module Youmagine
  class Document < ApiModel
    ACCEPTED_FILE_FORMATS = %i(stl).freeze
    accept_attributes :name, :alternative_formats, :rendered_image
    attr_reader :file

    def self.all(design_id:)
      multiple_from_json_response(get("/designs/#{design_id}/documents"))
    end

    def alternative_formats=(file_data)
      @file = file_data.
        map { |format, data| [format.to_s.gsub("_file", "").to_sym, data] }.
        select { |format, _data| format.in?(ACCEPTED_FILE_FORMATS) }.
        map { |format, data| [format, data[:url]] }.
        to_h
    end

    def rendered_image=(rendered_image_data)
      if rendered_image_data.present?
        @rendered_image = self.class.process_image_data(rendered_image_data)
      end
    end

    def printable?
      file[:stl].present?
    end
  end
end
