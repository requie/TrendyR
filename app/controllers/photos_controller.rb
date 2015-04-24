class PhotosController < ApplicationController
  before_action :set_photo, only: [:crop, :destroy]

  def create
    @photo = Photo.new(photo_params).decorate
    @photo.uploader = current_user
    @photo.save
  end

  def crop
    authorize @photo
    @photo.update(crop_photo_params)
    @preset = params[:preset].to_sym
  end

  def destroy
    authorize @photo
    @photo.destroy
    head :ok
  end

  private

  def set_photo
    @photo = Photo.find(params[:id]).decorate
  end

  def photo_params
    params.require(:photo).permit(:attachment)
  end

  def crop_photo_params
    params.require(:photo).permit(:crop_x, :crop_y, :crop_w, :crop_h)
  end

  def verify_authorized
    authorize :base, :access?
  end
end
