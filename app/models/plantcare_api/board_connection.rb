# frozen_string_literal: true

module PlantcareApi
  class BoardConnection < PlantcareApi::Base
    collection_path "boards/:board_id/board_connections"

    attributes :connected_at
  end
end
