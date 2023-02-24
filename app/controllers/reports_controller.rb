class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.order(:created_at, :id).page(params[:page])
  end

  def show
    @comments = @report.comments.order(:created_at, :id)
  end

  def new
    @report = current_user.reports.new
  end

  def edit
    redirect_to report_url(@report), notice: t('controllers.report.cannot_edit_other_user_report') if @report.user != current_user
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to report_url(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to report_url(@report), notice: t('controllers.report.cannot_delete_other_user_report') if @report.user != current_user
    @report.destroy
    redirect_to books_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
