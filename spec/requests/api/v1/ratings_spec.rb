# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Ratings', type: :request do
  let(:logged_in_user) { create(:user) }
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before { login(logged_in_user) }

  let(:params) do
    {
      rating: {
        rating: number
      }
    }
  end
  let(:number) { 3 }

  describe '#index' do
    context 'when user ratings index' do
      before { get "/api/v1/users/#{user.id}/ratings" }

      it { expect(response).to have_http_status(:ok) }
    end

    context 'when recipe ratings index' do
      before { get "/api/v1/recipes/#{recipe.id}/ratings" }

      it { expect(response).to have_http_status(:ok) }
    end
  end

  describe '#create' do
    context 'when valid params are passed' do
      before { post "/api/v1/recipes/#{recipe.id}/ratings/", params: params }

      it { expect(response).to have_http_status(:created) }
    end

    context 'when params are missing' do
      let(:number) { nil }
      before { post "/api/v1/recipes/#{recipe.id}/ratings/", params: params }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json_body[:errors][:rating]).to include("can't be blank") }
    end
  end

  describe '#update' do
    context 'when valid params are passed' do
      before do
        rating = create(:rating, recipe: recipe, user: logged_in_user)
        put "/api/v1/recipes/#{recipe.id}/ratings/#{rating.id}", params: params
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'when params are missing' do
      let(:number) { nil }
      before do
        rating = create(:rating, recipe: recipe, user: logged_in_user)
        put "/api/v1/recipes/#{recipe.id}/ratings/#{rating.id}", params: params
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json_body[:errors][:rating]).to include("can't be blank") }
    end

    context 'when rating not of current user' do
      before do
        rating = create(:rating, recipe: recipe, user: user)
        put "/api/v1/recipes/#{recipe.id}/ratings/#{rating.id}", params: params
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe '#destroy' do
    context 'when owner rating is current user' do
      before do
        rating = create(:rating, recipe: recipe, user: logged_in_user)
        delete "/api/v1/users/#{logged_in_user.id}/ratings/#{rating.id}"
      end

      it { expect(response).to have_http_status(:accepted) }
    end

    context 'when owner rating not current user' do
      before do
        rating = create(:rating, recipe: recipe, user: user)
        delete "/api/v1/users/#{user.id}/ratings/#{rating.id}"
      end

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(json_body[:errors]).to include('You are not allowed to change ratings that are not yours') }
    end
  end
end
