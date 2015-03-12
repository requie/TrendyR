class PhotosController < ApplicationController
  def create
    @photo = Photo.new(photo_params)
    authorize @photo
    @photo.uploader = current_user
    @photo.save
  end

  def crop
    @photo = Photo.find(params[:id])
    authorize @photo
    @photo.update(crop_photo_params)
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    render nothing: true
  end

  private

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
