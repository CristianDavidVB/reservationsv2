require 'rails_helper'

RSpec.describe "Restaurant Request", type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers}
  let!(:restaurants) { create_list(:restaurant, 3) }
  let(:restaurant_id) { restaurants.first.id }

  describe "GET /api/v1/restaurants" do
    before { get '/api/v1/restaurants', headers: headers }

    it "returns all restaurants" do
      expect(response_body['data'].size).to eq(3)
    end

    it "return status code 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET /api/v1/restaurants/:id" do
    before  { get "/api/v1/restaurants/#{restaurant_id}", headers: headers }

    context "When the restaurant exist" do
      it "return the id" do
        expect(response_body['data']['attributes']['id']).to eq(restaurant_id)
      end

      it "return status code 200" do
        expect(response.status).to eq(200)
      end
    end

    context "When the restaurant does not exist" do
      let(:restaurant_id) { -1 }

      it "return status code 404" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST /api/v1/restaurants" do
    let(:valid_attributes) { { name:'palenque', 
                               description: 'expertos en mariscos', 
                               address: 'calle 14', 
                               city: 'Barranquilla',
                               photo: 'photo.png'  }.to_json }
                              
    before { post "/api/v1/restaurants", params: valid_attributes, headers: headers }

    context "When the request is valid" do
      it "return name" do
        expect(response_body['data']['attributes']["name"]).to eq("palenque")
      end

      it "return status code 201" do
        expect(response.status).to eq(201)
      end
    end

    context "When the request is invalid" do
      let(:valid_attributes) { { name: "" }.to_json }
      before { post "/api/v1/restaurants", params: valid_attributes, headers: headers }
      it "return status code 422" do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /api/v1/restaurants/:id" do
    let(:valid_attributes) { { name: "Puro sabor" }.to_json }
    before { put "/api/v1/restaurants/#{restaurant_id}", params: valid_attributes, headers: headers }

    context "When the request is valid" do

      it "return name" do
        expect(response_body['data']['attributes']["name"]).to eq("Puro sabor")
      end

      it "return status code 200" do
        expect(response.status).to eq(200)
      end
    end

    context "When the request is invalid" do
      let(:valid_attributes) { { name: "" }.to_json }
      before { put "/api/v1/restaurants/#{restaurant_id}", params: valid_attributes, headers: headers }

      it "return status code 422" do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /api/v1/restaurants/:id' do
    before { delete "/api/v1/restaurants/#{restaurant_id}", headers: headers }

    it 'returns status code 204' do
      expect(response.status).to eq(204)
    end
  end
end