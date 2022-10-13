require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:logged_in_user) { create(:user) }
  before { login(logged_in_user) }

  let(:params) do
    {
      user: {
        username: username,
        password: 'password',
        password_confirmation: password_confirmation
      }
    }
  end

  let(:username) { 'username' }
  let(:password_confirmation) { 'password' }

  describe '#index' do
    before { get '/api/v1/users' }

    it { expect(response).to have_http_status(:ok) }
  end

  describe '#show' do
    context 'when user exists' do
      before do
        user = create(:user)
        get "/api/v1/users/#{user.id}"
      end
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when user not found' do
      before { get '/api/v1/users/1' }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json_body[:errors]).to include("Couldn't find User {id: 1}") }
    end
  end

  describe '#create' do
    let(:password_confirmation) { 'password' }

    context 'when valid params are passed' do
      before { post '/signup', params: params }

      it { expect(response).to have_http_status(:created) }
    end

    context 'when wrong all params are passed' do
      let(:password_confirmation) { 'WrongConfirmation' }
      before { post '/signup', params: params }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json_body[:errors][:password_confirmation]).to include("doesn't match Password") }
    end
  end

  describe '#update' do
    context 'when user is current user' do
      before do
        put "/api/v1/users/#{logged_in_user.id}", params: params
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'when user not current user' do
      before { put '/api/v1/users/1', params: params }
      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json_body[:errors]).to include('You are not allowed to update or destroy another user') }
    end

    context 'when params are wrong' do
      let(:password_confirmation) { 'Wrong' }

      before do
        put "/api/v1/users/#{logged_in_user.id}", params: params
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json_body[:errors][:password_confirmation]).to include("doesn't match Password") }
    end
  end

  describe '#destroy' do
    context 'when user is current user' do
      before do
        delete "/api/v1/users/#{logged_in_user.id}"
      end

      it { expect(response).to have_http_status(:accepted) }
    end

    context 'when user not found' do
      before { delete '/api/v1/users/1' }

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(json_body[:errors]).to include('You are not allowed to update or destroy another user') }
    end
  end
end
