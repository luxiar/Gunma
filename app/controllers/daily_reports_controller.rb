class DailyReportsController < ApplicationController
  load_and_authorize_resource

  def index
    @daily_reports = @daily_reports.includes(:user)
    @daily_reports = @daily_reports.where(user: params[:user]) if params[:user].present?
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
end
