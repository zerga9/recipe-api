require 'rails_helper'

RSpec.describe 'Api::V1::Ingredients', type: :request do
  let(:logged_in_user) { create(:user) }
  let(:recipe) { create(:recipe) }

  before { login(logged_in_user) }

  let(:params) do
    {
      ingredient: {
        name: name,
        metric: {
          amount: 100,
          unit: 'gram'
        },
        imperial: {
          amount: 3.5,
          unit: 'ounce'
        }
      }
    }
  end
  let(:name) { 'Cheese' }

  describe '#index' do
    before do
      get "/api/v1/recipes/#{recipe.id}/ingredients"
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe '#show' do
    context 'when ingredient exists' do
      before do
        ingredient = create(:ingredient, recipe: recipe)
        get "/api/v1/recipes/#{recipe.id}/ingredients/#{ingredient.id}"
      end
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when ingredient not found' do
      before { get "/api/v1/recipes/#{recipe.id}/ingredients/1" }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json_body[:errors]).to include("Couldn't find Ingredient {id: 1}") }
    end
  end

  describe '#create' do
    context 'when valid params are passed' do
      before { post "/api/v1/recipes/#{recipe.id}/ingredients/", params: params }

      it { expect(response).to have_http_status(:created) }
    end

    context 'when params are missing' do
      let(:name) { '' }
      before { post "/api/v1/recipes/#{recipe.id}/ingredients/", params: params }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json_body[:errors][:name]).to include("can't be blank") }
    end
  end

  describe '#update' do
    context 'when owner recipe is current_user' do
      before do
        recipe = create(:recipe, user: logged_in_user)
        ingredient = create(:ingredient, recipe: recipe)
        put "/api/v1/recipes/#{recipe.id}/ingredients/#{ingredient.id}", params: params
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'when recipe owner not current user' do
      before do
        ingredient = create(:ingredient, recipe: recipe)
        put "/api/v1/recipes/#{recipe.id}/ingredients/#{ingredient.id}", params: params
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it { expect(json_body[:errors]).to include('You are not allowed to change recipes that are not yours') }
    end

    context 'when params empty' do
      let(:name) { '' }

      before do
        recipe = create(:recipe, user: logged_in_user)
        ingredient = create(:ingredient, recipe: recipe)
        put "/api/v1/recipes/#{recipe.id}/ingredients/#{ingredient.id}", params: params
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it { expect(json_body[:errors][:name]).to include("can't be blank") }
    end
  end

  describe '#destroy' do
    context 'when recipe owner is current user' do
      before do
        recipe = create(:recipe, user: logged_in_user)
        ingredient = create(:ingredient, recipe: recipe)
        delete "/api/v1/recipes/#{recipe.id}/ingredients/#{ingredient.id}"
      end

      it { expect(response).to have_http_status(:accepted) }
    end

    context 'when owner not current user' do
      before do
        ingredient = create(:ingredient, recipe: recipe)
        delete "/api/v1/recipes/#{recipe.id}/ingredients/#{ingredient.id}"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json_body[:errors]).to include('You are not allowed to change recipes that are not yours') }
    end
  end
end
