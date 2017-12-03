require "authenticators/basic_auth"

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :basic_auth
  manager.failure_app = ->(env){ AuthController.action(:index).call(env) }
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    puts "record: #{record.try(:inspect)}"
    puts "serialized: #{[record.class.name, record.id]}"
    [record.class.name, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    puts "klass: #{klass}"
    puts "id: #{id}"
    eval(klass).find(id)
  end
end

Warden::Strategies.add(:basic_auth, BasicAuth)
