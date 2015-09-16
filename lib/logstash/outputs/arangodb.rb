require "logstash/namespace"
require "logstash/outputs/base"
require "ashikawa-core"

class LogStash::Outputs::ArangoDB < LogStash::Outputs::Base

  config_name 'arangodb'

  # The URL used to connect to the database.
  config :url, :validate => :string, :default => "http://localhost:8529"

  # The database that is going to be used
  config :database, :validate => :string, :default => "logstash"

  # The username used when authenticating with ArangoDB
  config :username, :validate => :string, :required => true

  # The password used when authenticating with ArangoDB
  config :password, :validate => :password, :required => true

  # The collection used to log the events, by default it will create a collection
  # per day of logs following the pattern logstash-%{+YYYY-MM-dd}
  config :collection, :validate => :string, :default => "logstash-%{+YYYY-MM-dd}"

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
    collection.create_document(event.to_hash)
  end

  private

  def collection
    @instance ||= @database[@collection]
  end

end
