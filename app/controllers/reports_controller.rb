class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.order(:created_at, :id).page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end
end
