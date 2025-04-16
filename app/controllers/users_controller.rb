# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end

  def liked
    @user = User.find_by!(username: params.fetch(:username))
  end

  def feed
    @user = current_user
  end

  def discover
    @user = User.find_by!(username: params.fetch(:username))
  end
end
