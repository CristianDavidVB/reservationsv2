module Api
  module V1
    class ReservationsController < ApplicationController
      skip_before_action :authorize_request, only: %i[create]
      
      before_action :reservation, only: %i[show]

      def index
        @reservations = Reservation.all
        render json: serializer(@reservations)
      end
    
      def show
        render json: serializer(@reservation)
      end
    
      def create
        @reservation = Reservation.new(reservation_params)
        if @reservation.save
    
          render json: serializer(@reservation), status: :created
          ReservationConfirmationMailer.reservation_confirmation(@reservation).deliver_later
        else
          render json: @reservation.errors, status: :unprocessable_entity
        end
      end
    
      private
      def reservation_params
        params.require(:reservation).permit(:number_tables, :customer_name, :customer_email, :date, :restaurant_id)
      end
    
      def reservation
        @reservation = Reservation.find(params[:id])
      end
    
      def serializer(object)
        ReservationSerializer.new(object).serializable_hash.to_json
      end
    end
  end
end


