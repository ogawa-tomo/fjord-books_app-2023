# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    comment = commentable.comments.build(comment_params)
    if comment.save
      redirect_to comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to comment.commentable, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      redirect_to commentable, notice: t('controllers.comment.cannot_delete_other_user_comment')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :user_id)
  end

  def commentable
    if params.include?(:book_id)
      Book.find(params[:book_id])
    elsif params.include?(:report_id)
      Report.find(params[:report_id])
    else
      raise
    end
  end
end
