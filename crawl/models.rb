require 'dry-data'
require 'uri'

module Types

end

Dry::Data.configure do |config|
  config.namespace = Types
end

Dry::Data.finalize
module Types
  Url = String.constrained(format: URI.regexp )
  OptionalUrl = String.constrained(format: URI.regexp ).optional
end

require_relative 'models/show'
require_relative 'models/episode_info'
