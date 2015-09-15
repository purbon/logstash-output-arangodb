require "logstash/namespace"
require "logstash/outputs/base"
require "ashikawa-core"

class LogStash::Outputs::ArangoDB < LogStash::Outputs::Base

  config_name 'arangodb'

  # The URL used to connect to the database.
  config :url, :validate => :string, :default => "http://localhost:8529"

  # The database that is going to be used, _system is the default one.
  config :database, :validate => :string

  # The username used when authenticating with ArangoDB
  config :username, :validate => :string, :required => true

  # The password used when authenticating with ArangoDB
  config :password, :validate => :password, :required => true

  def register
    @database = Ashikawa::Core::Database.new do |config|
      config.url = @url
      config.database_name = @database if @database
      config.username = @username
      config.password = @password.value
    end
  end

  def receive(event)
    return unless output?(event)
    @database["logstash-logs"].create_document(event.to_hash)
  end

end
