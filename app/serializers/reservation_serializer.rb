class ReservationSerializer
  include JSONAPI::Serializer
  attributes :id, :number_tables, :customer_name, :customer_email, :date
end
