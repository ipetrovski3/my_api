# frozen_string_literal: true

require 'rails_helper'

describe 'Farms', type: :request do
  describe 'GET /api/v1/farms' do
    let(:path) { '/api/v1/auth/sign_in' }
    let!(:user) { create(:user) }
    let!(:farm) { create(:farm, user: user) }

    it 'returns status code' do
      get api_v1_farms_path, headers: user.create_new_auth_token.merge, xhr: true
      expect(response).to have_http_status(200)
    end

    it 'returns all created farms' do
      get api_v1_farms_path, headers: user.create_new_auth_token.merge, xhr: true
      expect(json_response_body.first['size']).to eq(1000)
    end
  end

  describe 'POST /api/v1/farms' do
    let(:path) { '/api/v1/auth/sign_in' }
    let!(:user) { create(:user) }


    context 'with valid params' do
      let(:params) do
        { farm:
          {
            address: 'Amsterdam',
            size: 2000,
            farm_yield: 45
          } }
      end

      it 'returns status code 201' do
        post api_v1_farms_path, headers: user.create_new_auth_token.merge, xhr: true, params: params
        expect(response).to have_http_status(201)
        expect(Farm.count).to eq(1)
      end

      it 'return created JSON' do
        post api_v1_farms_path, headers: user.create_new_auth_token.merge, xhr: true, params: params
        expect(json_response_body['address']).to match('Amsterdam')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { farm: {
          address: '',
          size: '',
          farm_yield: ''
        } }
      end

      it 'returns status code 422' do
        post api_v1_farms_path, headers: user.create_new_auth_token.merge, xhr: true, params: invalid_params
        expect(response).to have_http_status(422)
      end

      it 'returns a error message' do
        post api_v1_farms_path, headers: user.create_new_auth_token.merge, xhr: true, params: invalid_params
        expect(json_response_body['message']).to include('address' => ["can't be blank"])
      end
    end
  end

  describe 'PUT /api/v1/farms/:id' do
    let(:path) { '/api/v1/auth/sign_in' }
    let!(:user) { create(:user) }
    let!(:farm) { create(:farm, user: user) }

    it 'returns status code 200' do
      put api_v1_farm_path(farm.id), headers: user.create_new_auth_token.merge, xhr: true, params: {
        farm: { address: 'Skopje, Macedonia' }
      }
      expect(response).to have_http_status(200)
    end

    it 'returns the updated json' do
      put api_v1_farm_path(farm.id), headers: user.create_new_auth_token.merge, xhr: true, params: {
        farm: { address: 'Skopje, Macedonia' }
      }
      expect(json_response_body['address']).to eq('Skopje, Macedonia')
    end
  end

  describe 'DELETE /api/v1/farms/:id' do
    let(:path) { '/api/v1/auth/sign_in' }
    let!(:user) { create(:user) }
    let!(:farm) { create(:farm, user: user) }

    it 'deletes a farms' do
      delete api_v1_farm_path(farm.id), headers: user.create_new_auth_token.merge, xhr: true

      expect(Farm.count).to eq(0)
    end
  end
end
