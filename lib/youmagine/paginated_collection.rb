module Youmagine
  class PaginatedCollection < ::Array
    PAGINATION_PARAMS = %i(first_page previous_page current_page
                           next_page last_page total_count per_page).freeze

    attr_reader *PAGINATION_PARAMS
    alias_method :total_pages, :last_page

    def initialize(records, response_headers)
      replace(records)
      parse_pagination_headers(response_headers)
    end

    def parse_pagination_headers(response_headers)
      PAGINATION_PARAMS.each do |param_name|
        value = response_headers["x_pagination_#{param_name}".dasherize].to_i
        instance_variable_set "@#{param_name}", value
      end
    end
  end
end
