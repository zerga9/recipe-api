# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:user][:username])

    if user&.authenticate(params[:user][:password])
      session[:user_id] = user.id
      render json: { status: 'You are logged in' }
    else
      render json: { errors: ['Invalid username or password'] }, status: :not_found
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { status: 'You are logged out' }
  end
end
