class Reservation < ApplicationRecord
  belongs_to :restaurant
  validates :number_tables, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :customer_name,
            :date,
            presence: true
  validates :customer_email, presence: true, uniqueness: true
  validates_format_of :customer_email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "must be a valid email address"

  validate :maximum_reservations_per_day

  private

  def maximum_reservations_per_day
    if restaurant.reservations.where(date: date).sum(:number_tables) + number_tables > 15
      errors.add(:base, 'Maximum number of tables for this restaurant on this day has been reached.')
    end

    if Reservation.where(date: date).sum(:number_tables) + number_tables > 20
      errors.add(:base, 'Maximum number of tables for all restaurants on this day has been reached.')
    end
  end
end