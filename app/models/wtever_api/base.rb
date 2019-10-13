module WteverApi
  class Base
    include Her::JsonApi::Model
    # defaults to demodulized, pluralized class name, e.g. contributors
    type :developers

    def update_with_attributes(attributes)
      assign_attributes(attributes)
      save
    end
  end
end
