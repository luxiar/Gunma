class DailyReportsController < ApplicationController
  load_and_authorize_resource

  def index
    @daily_reports = @daily_reports.includes(:user).order(created_at: :desc)

    @daily_reports = @daily_reports.where(search_params) if params[:search].present?

    @daily_reports = @daily_reports.page(params[:page])
  end

  def show; end

  def new; end

  def edit; end

  def create
    @daily_report.user = current_user
    if @daily_report.save
      redirect_to daily_report_url(@daily_report), notice: '日報が作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @daily_report.update(daily_report_params)
      redirect_to daily_report_url(@daily_report), notice: '日報が更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @daily_report.destroy!

    redirect_to daily_reports_url, notice: '日報が削除されました'
  end

  private

  def daily_report_params
    params.require(:daily_report).permit(:title, :content, :mood)
  end

  def search_params
    params.require(:search).permit(:user)
  end
end
