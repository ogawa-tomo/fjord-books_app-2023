# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)
    ApplicationRecord.transaction do
      @report.save!
      create_mentioning_to!
    end
    redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
  rescue
    render :new, status: :unprocessable_entity
  end

  def update
    ApplicationRecord.transaction do
      @report.mentioning_to.clear
      @report.update!(report_params)
      create_mentioning_to!
    end
    redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
  rescue
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def create_mentioning_to!
    report_urls = @report.content.scan(/http:\/\/localhost:3000\/reports\/\d+/).uniq
    report_ids = report_urls.map { |url| url.match(/\/reports\//).post_match }.map(&:to_i)
    report_ids.each do |report_id|
      @report.mentioning_to.create!(mentioned_report_id: report_id)
    end
  end
end
