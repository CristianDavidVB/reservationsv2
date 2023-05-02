module Api
  module V1
    class RestaurantsController < ApplicationController
      skip_before_action :authorize_request, only: %i[index show]

      before_action :restaurant, only: %i[show update destroy]

      def index
        @restaurants = RestaurantFinder.new.call(params)
        render json: serializer(@restaurants)
      end
    
      def show
          render json:  serializer(@restaurant)
        end
    
      def create
        @restaurant = Restaurant.new(restaurant_params)
        if @restaurant.save
          render json: serializer(@restaurant), status: :created
        else
          render json: @restaurant.errors, status: :unprocessable_entity
        end
      end
    
      def update
        if @restaurant.update(restaurant_params)
          render json: serializer(@restaurant)
        else
          render json: @restaurant.errors, status: :unprocessable_entity
        end
      end
    
      def destroy
        @restaurant.destroy
      end
    
      private
    
      def restaurant_params
        params.permit(:name, :description, :address, :city, :photo)
      end
    
      def restaurant
        @restaurant = Restaurant.find(params[:id])
      end
    
      def serializer(object)
        RestaurantSerializer.new(object).serializable_hash.to_json
      end
    end
  end
end


