module WteverApi
  class Base
    include Her::JsonApi::Model
    # defaults to demodulized, pluralized class name, e.g. contributors
    type :developers
  end
end
