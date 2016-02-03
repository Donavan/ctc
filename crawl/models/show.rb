class Show < Dry::Data::Struct
  attribute :title, Types::String
  attribute :episodes, Types::Maybe::Coercible::Array
end