# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      before_action :authenticate_user
      before_action :require_permission, only: %i[update destroy]

      rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

      def index
        if params[:user_id]
          render json: Recipe.where(user_id: params[:user_id])
        else
          render json: Recipe.all
        end
      end

      def show
        return record_not_found unless recipe

        render json: recipe
      end

      def create
        new_recipe = current_user.recipes.new(recipe_params)

        new_recipe.save!

        render json: new_recipe, status: :created
      end

      def update
        render json: recipe, status: :ok if recipe.update!(recipe_params)
      end

      def destroy
        if recipe.destroy!
          render json: { recipe: recipe }, status: :accepted
        else
          render json: { errors: recipe.errors }, status: 500
        end
      end

      private

      def id
        params.require(:id)
      end

      def recipe
        @recipe ||= Recipe.find_by(id: id)
      end

      def require_permission
        return if recipe.user == current_user

        render json: { errors: ['You are not allowed to change recipes that are not yours'] },
               status: :unauthorized
      end

      def recipe_params
        params.require(:recipe).permit(:title, :description, :process,
                                       ingredients_attributes: [:id, :name, metric: %i[amount unit], imperial: %i[amount unit]])
      end

      def invalid_record(exception)
        render json: { errors: exception.record.errors }, status: :unprocessable_entity
      end

      def record_not_found
        render json: { errors: ["Couldn't find Recipe {id: #{id}}"] }, status: :not_found
      end
    end
  end
end
