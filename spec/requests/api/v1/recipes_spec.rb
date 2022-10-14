# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Recipes', type: :request do
  let(:logged_in_user) { create(:user) }
  before { login(logged_in_user) }

  let(:params) do
    {
      recipe: {
        title: title,
        description: 'RecipeDescription',
        process: 'RecipeProcess'
      }
    }
  end
  let(:title) { 'RecipeTitle' }

  describe '#index' do
    before { get '/api/v1/recipes' }

    it { expect(response).to have_http_status(:ok) }
  end

  describe '#show' do
    context 'when recipe exists' do
      before do
        recipe = create(:recipe)
        get "/api/v1/recipes/#{recipe.id}"
      end
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when recipe not found' do
      before { get '/api/v1/recipes/1' }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json_body[:errors]).to include("Couldn't find Recipe {id: 1}") }
    end
  end

  describe '#create' do
    context 'when valid params are passed' do
      before { post '/api/v1/recipes', params: params }

      it { expect(response).to have_http_status(:created) }
    end

    context 'when params are missing' do
      let(:title) { '' }
      before { post '/api/v1/recipes', params: params }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json_body[:errors][:title]).to include("can't be blank") }
    end
  end

  describe '#update' do
    context 'when owner recipe is current_user' do
      before do
        recipe = create(:recipe, user: logged_in_user)
        put "/api/v1/recipes/#{recipe.id}", params: params
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'when recipe owner not current user' do
      before do
        recipe = create(:recipe)
        put "/api/v1/recipes/#{recipe.id}", params: params
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json_body[:errors]).to include('You are not allowed to change recipes that are not yours') }
    end

    context 'when params empty' do
      let(:title) { '' }

      before do
        recipe = create(:recipe, user: logged_in_user)
        put "/api/v1/recipes/#{recipe.id}", params: params
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json_body[:errors][:title]).to include("can't be blank") }
    end
  end

  describe '#destroy' do
    context 'when recipe owner is current user' do
      before do
        recipe = create(:recipe, user: logged_in_user)
        delete "/api/v1/recipes/#{recipe.id}"
      end

      it { expect(response).to have_http_status(:accepted) }
    end

    context 'when owner not current user' do
      before do
        recipe = create(:recipe)
        delete "/api/v1/recipes/#{recipe.id}"
      end

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(json_body[:errors]).to include('You are not allowed to change recipes that are not yours') }
    end
  end
end
