class CommentsController < ApplicationController
  def create
    @comment = current_photo.comments.build(comment_params)
    @comment.user_id  = current_user.id
    @comment.other_id = current_user.id
    if @comment.save!
      flash[:success] = "Cometted"
      redirect_to user_path(current_user)
    else
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
