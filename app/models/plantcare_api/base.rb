# frozen_string_literal: true

module PlantcareApi
  class Base
    include Her::Model

    def update_with_attributes(attributes)
      assign_attributes(attributes)
      save
    end
  end
end
