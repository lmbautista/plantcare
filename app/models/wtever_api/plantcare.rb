module WteverApi
  class Plantcare < WteverApi::Base

    attributes :name, :kind, :planted_at, :watered_at, :wet, :status
  end
end
