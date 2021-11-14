class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    #投稿に紐づいたコメントを作成
    @comment = @post.post_comments.build(post_comment_params)
    @comment.user_id = current_user.id
    @comment_post = @comment.post
    if @comment.save
      #通知の作成
      @comment_post.create_notification_comment!(current_user, @comment.id)
      redirect_to post_path(@post)
    end
  end

  def destroy
    PostComment.find_by(id: params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
