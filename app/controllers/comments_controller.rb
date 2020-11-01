class CommentsController < ApplicationController
  def create
    if @comment = Comment.create(comment_params) #ストパラでプロトタイプのid情報も取ってきている
    redirect_to prototype_path(@comment.prototype.id) #コメントに対してのプロトタイプを一つ取得することができる@prototype.commentsの逆パターン
  else
    render "prototype/show"
  end

  end
  


  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
