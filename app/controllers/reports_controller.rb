class ReportsController < ApplicationController
  def index
    @reports = Report.order(:created_at, :id).page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end
end
