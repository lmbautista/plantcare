# frozen_string_literal: true

module WteverApi
  class Board < WteverApi::Base
    attributes :auth_token,
               :configured,
               :calibrated,
               :status,
               :last_connection_at
  end
end
