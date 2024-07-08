class ThumbsUpsController < ApplicationController
  before_action :set_daily_report

  def create
    @daily_report.liked_users << current_user
    render partial: 'daily_reports/thumbs_up', locals: { daily_report: @daily_report }
  end

  def destroy
    @daily_report.liked_users.destroy(current_user)
    render partial: 'daily_reports/thumbs_up', locals: { daily_report: @daily_report }
  end

  private

  def set_daily_report
    @daily_report = DailyReport.find(params[:daily_report_id])
  end
end
