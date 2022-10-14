# frozen_string_literal: true

module Api
  module V1
    class RatingsController < ApplicationController
      before_action :authenticate_user
      before_action :require_permission, only: %i[update destroy]
      rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

      def index
        render json: Rating.where(recipe_id: params[:recipe_id])
      end

      def create
        new_rating = recipe.ratings.build(rating_params)
        new_rating.user = current_user
        new_rating.save!

        render json: new_rating, status: :created
      end

      def update
        render json: rating, status: :ok if rating.update!(rating_params)
      end

      def destroy
        if rating.destroy!
          render json: rating, status: :accepted
        else
          render json: { errors: rating.errors }, status: :unprocessable_entity
        end
      end

      private

      def recipe
        @recipe ||= Recipe.find(params[:recipe_id])
      end

      def rating
        @rating ||= Rating.find_by(id: params[:id])
      end

      def require_permission
        return if rating.user == current_user

        render json: { errors: ['You are not allowed to change ratings that are not yours'] },
               status: :unauthorized
      end

      def rating_params
        params.require(:rating).permit(:rating)
      end

      def invalid_record(exception)
        render json: { errors: exception.record.errors }, status: :unprocessable_entity
      end

      def record_not_found
        render json: { errors: ["Couldn't find Rating #{params[:id]}"] }, status: :not_found
      end
    end
  end
end
