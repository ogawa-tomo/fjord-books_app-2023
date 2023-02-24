# frozen_string_literal: true

class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      if @comment.commentable_type == 'Book'
        redirect_to book_url(@comment.commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
      elsif @comment.commentable_type == 'Report'
        redirect_to report_url(@comment.commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
      else
        redirect_to root_url
      end
    else
      if @comment.commentable_type == 'Book'
        redirect_to book_url(@comment.commentable), status: :unprocessable_entity
      elsif @comment.commentable_type == 'Report'
        redirect_to report_url(@comment.commentable), status: :unprocessable_entity
      else
        redirect_to root_url, status: :unprocessable_entity
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :user_id, :commentable_type, :commentable_id)
  end
end