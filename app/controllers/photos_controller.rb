require 'exifr'

class PhotosController < ApplicationController
  before_action :signed_in_user

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:sucess] = "Photo uploaded"
      redirect_to user_path(current_user)
    end
  end

  def destroy
  end

  private

  def photo_params
    params.require(:photo).permit(:took_date)
  end
end
