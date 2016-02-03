class Episode < Dry::Data::Struct
  attribute :show_id, Types::String
  attribute :title, Types::String
  attribute :url, Types::Url
  attribute :source, Types::Coercible::String
  attribute :air_date, Types::Form::Date
  attribute :thumbnail_url, Types::Url
  attribute :episode_no, Types::String
  attribute :rating, Types::String
end