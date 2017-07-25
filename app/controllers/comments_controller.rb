class CommentsController < ApplicationController
  def create
  @article = Article.find(params[:article_id])
  @comment = @article.comments.create(comment_params)
  if @comment.save
      respond_to do |format|
        format.html { redirect_to article_path(@comment.article), notice: 'Thanks for your comment'}
        format.js
    else
      respond_to do |format|
        format.html { redirect_to @comment.article, alert: 'Unable to add comment' }
        format.js { render 'fail_create.js.erb' }
      end
    end
end


def destroy
  @article = Article.find(params[:article_id])
  @comment = @article.comments.find(params[:id])
  @comment.destroy
  respond_to do |format|
      format.html { redirect_to article_path(@comment.article), notice: 'Comment Deleted' }
      format.js
    end
end

private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
end
