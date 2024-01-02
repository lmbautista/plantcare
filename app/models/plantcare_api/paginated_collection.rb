# frozen_string_literal: true

module PlantcareApi
  class PaginatedCollection
    def initialize(records, pagination_params = {})
      @records = records
      @pagination_params = pagination_params.transform_values(&:to_i)
    end

    def current_page
      pagination_params[:current_page]
    end

    def total_pages
      pagination_params[:total_pages]
    end

    def total_count
      pagination_params[:total_count]
    end

    def limit
      pagination_params[:per_page]
    end

    def offset_value
      pagination_params[:per_page] * (pagination_params[:current_page] - 1)
    end

    def limit_value
      pagination_params[:per_page]
    end

    private

    attr_reader :records, :pagination_params

    delegate :each, to: :records
  end
end
