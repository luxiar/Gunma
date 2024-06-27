class DailyReportsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => :index

  def index
    if params[:search].present?
      @daily_reports = DailyReport.where(search_params).order(created_at: :desc).includes(:user)
    else
      @daily_reports = DailyReport.all.limit(10).order(created_at: :desc).includes(:user)
    end
  end

  def show; end

  def new; end

  def edit; end

  def create
    if @daily_report.save
      redirect_to daily_report_url(@daily_report), notice: 'Daily report was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @daily_report.update(daily_report_params)
      redirect_to daily_report_url(@daily_report), notice: 'Daily report was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @daily_report.destroy!

    redirect_to daily_reports_url, notice: 'Daily report was successfully destroyed.'
  end

  private

  def daily_report_params
    params.require(:daily_report).permit(:title, :content, :mood)
  end

  def search_params
    params.require(:search).permit(:user)
  end
end
