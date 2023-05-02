class Restaurant < ApplicationRecord
  #has_one_attached :photo

  has_many :reservations

  validates :name, presence: true, uniqueness: true
  validates :address, :city, :photo, presence: true
end
