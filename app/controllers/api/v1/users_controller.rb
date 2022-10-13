# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, only: %i[index show update destroy]
      before_action :require_permission, only: %i[update destroy]

      rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

      def index
        render json: User.all
      end

      def show
        return record_not_found unless user

        render json: user, status: :ok
      end

      def create
        new_user = User.create!(user_params)

        render json: new_user, status: :created if new_user
      end

      def update
        return record_not_found unless user

        render json: user, status: :ok if user.update!(user_params)
      end

      def destroy
        return record_not_found unless user

        render json: user, status: :accepted if user.destroy!
      end

      private

      def id
        params.require(:id)
      end

      def user
        @user = User.find_by(id: id)
      end

      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
      end

      def require_permission
        return if user == current_user

        render json: { errors: ['You are not allowed to update or destroy another user'] },
               status: :unauthorized
      end

      def invalid_record(exception)
        render json: { errors: exception.record.errors }, status: :unprocessable_entity
      end

      def record_not_found
        render json: { errors: ["Couldn't find User {id: #{id}}"] }, status: :not_found
      end
    end
  end
end
