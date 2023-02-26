# frozen_string_literal: true

class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to commentable_url(@comment), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to commentable_url(@comment), status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      url = commentable_url(@comment)
      @comment.destroy
      redirect_to url, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)   
    else
      redirect_to commentable_url(@comment), notice: t('controllers.comment.cannot_delete_other_user_comment')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :user_id, :commentable_type, :commentable_id)
  end

  def commentable_url(comment)
    if comment.commentable_type == 'Book'
      book_url(comment.commentable)
    elsif comment.commentable_type == 'Report'
      report_url(comment.commentable)
    else
      raise
    end
  end
end