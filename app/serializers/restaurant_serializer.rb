class RestaurantSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :address, :city, :photo
end
