# frozen_string_literal: true

require "authenticators/basic_auth"

WARDEN_SESSION_TIMEOUT = 60

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :basic_auth
  manager.failure_app = ->(env) { AuthController.action(:index).call(env) }
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    [record.class.name, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    eval(klass).find(id)
  end
end

Warden::Strategies.add(:basic_auth, BasicAuth)
