# frozen_string_literal: true

module Api
  module V1
    class IngredientsController < ApplicationController
      before_action :authenticate_user
      before_action :require_permission, only: %i[update destroy]

      rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

      def index
        render json: recipe.ingredients
      end

      def show
        return record_not_found unless ingredient

        render json: ingredient
      end

      def create
        new_ingredient = recipe.ingredients.build(ingredient_params)
        new_ingredient.save!

        render json: new_ingredient, status: :created
      end

      def update
        render json: { ingredient: ingredient }, status: :ok if ingredient.update!(ingredient_params)
      end

      def destroy
        if ingredient.destroy!
          render json: { ingredient: ingredient }, status: :accepted
        else
          render json: { errors: ingredient.errors }, status: :unprocessable_entity
        end
      end

      private

      def require_permission
        return if recipe.user == current_user

        render json: { errors: ['You are not allowed to change recipes that are not yours'] },
               status: :unprocessable_entity
      end

      def recipe
        @recipe ||= Recipe.find(params[:recipe_id])
      end

      def ingredient
        @ingredient ||= Ingredient.find_by(id: params[:id])
      end

      def ingredient_params
        params.require(:ingredient).permit(:name, metric: {}, imperial: {})
      end

      def invalid_record(exception)
        render json: { errors: exception.record.errors }, status: :unprocessable_entity
      end

      def record_not_found
        render json: { errors: ["Couldn't find Ingredient {id: #{params[:id]}}"] }, status: :not_found
      end
    end
  end
end
