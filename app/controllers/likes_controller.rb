class LikesController < ApplicationController
  before_action :set_like, only: [:destroy]

  def create
    @like = Like.new(like_params)
    @like.fan = current_user   # ensures the current user is the fan

    if @like.save
      redirect_back fallback_location: root_path, notice: "Like was successfully created."
    else
      redirect_back fallback_location: root_path, alert: @like.errors.full_messages.to_sentence
    end
  end

  def destroy
    @like.destroy!
    redirect_back fallback_location: root_path, notice: "Like was successfully destroyed."
  end

  private

  def set_like
    @like = Like.find(params[:id])  # standard approach
  end

  def like_params
    params.require(:like).permit(:photo_id)  # no :fan_id, we set it manually
  end
end
