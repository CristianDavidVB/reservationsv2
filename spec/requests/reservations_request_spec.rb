require 'rails_helper'

RSpec.describe "Reservations Request", type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers}
  let!(:reservations) { create_list(:reservation, 3) }
  let(:reservation_id) { reservations.first.id }

  describe "GET /api/v1/reservations" do
    before { get '/api/v1/reservations', headers: headers }

    it "returns all reservations" do
      expect(response_body['data'].size).to eq(3)
    end

    it "return status code 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET /api/v1/reservations/:id" do
    before  { get "/api/v1/reservations/#{reservation_id}", headers: headers }

    context "When the tag reservation" do
      it "return the id" do
        expect(response_body['data']['attributes']['id']).to eq(reservation_id)
      end

      it "return status code 200" do
        expect(response.status).to eq(200)
      end
    end

    context "When the reservation does not exist" do
      let(:reservation_id) { -1 }

      it "return status code 404" do
        expect(response.status).to eq(404)
      end
    end
  end

  # describe "POST /api/v1/reservations" do
  #   let(:restaurant) { create(:restaurant) }
  #   let(:valid_attributes) { { number_tables: 5, 
  #                             customer_name: 'John Doe', 
  #                             customer_email: 'jhon@example.com',
  #                             date: Time.current,
  #                             restaurant_id: restaurant.id
  #                           }.to_json }
                              
  #   before { post "/api/v1/reservations", params: valid_attributes, headers: headers }

  #   context "When the request is valid" do
  #     it "return name" do
  #       expect(response_body['data']['attributes']["customer_name"]).to eq("John Doe")
  #     end

  #     it "return status code 201" do
  #       expect(response.status).to eq(201)
  #     end
  #   end

  #   context "When the request is invalid" do
  #     let(:valid_attributes) { { customer_name: '' }.to_json }
  #     before { post "/api/v1/reservations", params: valid_attributes, headers: headers }
  #     it "return status code 422" do
  #       expect(response.status).to eq(422)
  #     end
  #   end
  # end
end