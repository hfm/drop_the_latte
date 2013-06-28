require 'exifr'

class PhotosController < ApplicationController
  before_action :signed_in_user

  def create
    @photo = current_user.photos.build(photo_params)
    @photo.took_date = Time.now

    if @photo.save
      pic_path = (@photo.content).to_s
      pic_path_split = pic_path.split("/")
      pic_name = pic_path_split.last.split("?")
      path_num = "%03d" % ((@photo.id).to_i)

      @photo.took_date = (EXIFR::JPEG.new('public/system/photos/contents/000/000/' +
                                          path_num.to_s + '/original/' + pic_name[0])).date_time_original
      @photo.took_date ||= Time.now

      if  @photo.save
        flash[:success] = "Photo uploaded"        
        redirect_to user_path(current_user)
      else
        flash[:error] = "Photo upload error"
        redirect_to user_path(current_user)
      end
    else
      flash[:error] = "JPG, JPEG files are only supported"
      redirect_to user_path(current_user)
    end
  end

  def destroy
  end

  private

  def photo_params
    params.require(:photo).permit(:content)
  end
end
