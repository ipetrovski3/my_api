# frozen_string_literal: true

require 'rails_helper'

describe 'Registration', type: :request do
  describe 'POST /api/v1/auth', :vcr do
    subject(:request) { post path, params: params }

    let(:path) { '/api/v1/auth' }

    context 'when params valid' do
      let(:params) do
        {
          email: 'user@example.com',
          password: '12345678',
          password_confirmation: '12345678',
          confirm_success_url: '/',
          address: 'Skopje, Macedonia'
        }
      end
      # before do
      #   stub_request(:get, 'https://maps.googleapis.com/maps/api/geocode/json?address&key=AIzaSyBUt9hd__0_Bws1JdXmuoNXqpQSdiFyGHk&language=en')
      #     .to_return(status: 200)
      # end

      it 'returns status code' do
        request


        expect(response).to have_http_status(200)
      end

      it 'returns success status' do
        request

        expect(json_response_body['status']).to eq('success')
      end

      it 'creates new user' do
        expect { request }.to change { User.count }.by(1)
      end

      it 'returns proper headers', :aggregate_failures do
        request
        expect(response.headers['access-token']).to be_present
        expect(response.headers['client']).to be_present
        expect(response.headers['expiry']).to be_present
        expect(response.headers['uid']).to be_present
      end
    end

    context 'when invalid params' do
      let(:params) { {} }

      it 'returns status code' do
        request
        expect(response).to have_http_status(422)
      end

      it 'returns error status' do
        request

        expect(json_response_body['status']).to eq('error')
      end
    end
  end
end
