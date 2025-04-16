class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]

  def index
    @photos = Photo.all
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def edit
  end

  def create
    @photo = Photo.new(photo_params)
    # 1) Force the current user to be the owner
    @photo.owner_id = current_user.id

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy!
    respond_to do |format|
      format.html { redirect_to photos_url, status: :see_other, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_photo
      @photo = Photo.find(params[:id])
    end

    # 2) Permit only :image and :caption from the form.
    #    We don't allow :owner_id, :likes_count, :comments_count from the user input.
    def photo_params
      params.require(:photo).permit(:image, :caption)
    end
end
