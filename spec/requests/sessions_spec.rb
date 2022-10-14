# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create(:user) }

  describe 'POST /login' do
    context 'with valid credentials' do
      it 'lets the user login' do
        post '/login',
             params: { user: { username: user.username, password: user.password } }

        expect(json_body[:status]).to include('You are logged in')
      end
    end

    context 'with invalid credentials' do
      it 'does not let the user login' do
        post '/login',
             params: { user: { username: user.username, password: 'nottherightpassword' } }
        expect(response).to have_http_status(:not_found)
        expect(json_body[:errors]).to include('Invalid username or password')
      end
    end

    context 'when logging out' do
      it 'logs the user out' do
        delete '/logout'
        expect(json_body[:status]).to include('You are logged out')
      end
    end
  end
end
