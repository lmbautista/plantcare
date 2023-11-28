# frozen_string_literal: true

module PlantcareApi
  class Board < PlantcareApi::Base
    attributes :auth_token,
               :configured,
               :calibrated,
               :status,
               :last_connection_at
  end
end
