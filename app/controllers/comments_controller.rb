class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype.id)
    else
      @prototype = @comment.prototype #下記の記述の為に必要
      @comments = @prototype.comments.order(created_at: "DESC")
      render '/prototypes/show' #なぜprototype_pathや/prototypes/:idではないのか？
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end

