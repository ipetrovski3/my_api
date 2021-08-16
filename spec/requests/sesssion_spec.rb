# frozen_string_literal: true

require 'rails_helper'

describe 'Session', type: :request do
  describe 'POST /api/v1/auth/sign_in' do
    subject(:request) { post path, params: params }

    let(:path) { '/api/v1/auth/sign_in' }
    let!(:user) { create(:user) }

    context 'when params valid' do
      let(:params) do
        {
          email: user.email,
          password: user.password
        }
      end

      it 'returns status code' do
        request
        expect(response).to have_http_status(200)
      end

      it 'returns proper headers', :aggregate_failures do
        request
        expect(response.headers['access-token']).to be_present
        expect(response.headers['client']).to be_present
        expect(response.headers['expiry']).to be_present
        expect(response.headers['uid']).to be_present
        puts response.headers
      end
    end

    context 'when invalid params' do
      let(:params) { {} }

      it 'returns status code' do
        request
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /api/v1/auth/sign_out' do
    subject(:request) { delete path, headers: headers }

    let(:path) { '/api/v1/auth/sign_out' }
    let!(:user) { create(:user) }
    let(:headers) { user.create_new_auth_token }

    it 'returns status code' do
      request
      expect(response).to have_http_status(200)
    end
  end
end
