class IndexController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @daily_reports = DailyReport.all.order(created_at: :desc).limit(5).includes(:user, :learned_tags, :thumbs_ups)
  end
end
