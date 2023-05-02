class ReservationConfirmationMailer < ApplicationMailer
  def reservation_confirmation(reservation)
    @reservation = reservation
    @restaurant = reservation.restaurant
    mail(to: @reservation.customer_email, subject: "Reservation confirmed at #{@restaurant.id}")
  end
end
