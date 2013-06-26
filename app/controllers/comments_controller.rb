class CommentsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @comment = current_photo.comments.build(comment_params)
    if @comment.save
      flash[:sucess] = "Cometted"
      redirect_to user_path(current_user)
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
