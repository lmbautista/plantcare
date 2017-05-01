require "authenticators/basic_auth"

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :basic_auth
  manager.failure_app = ->(env){ AuthController.action(:index).call(env) }
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    [record.class.name, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    klass.find(:first, :conditions => { :id => id })
  end
end

Warden::Strategies.add(:basic_auth, BasicAuth)
