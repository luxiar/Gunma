class IndexController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      @daily_reports = DailyReport.all.order(created_at: :desc).limit(5)
    else
      @daily_reports = []
      user = User.new(last_name: 'example', first_name: 'user')
      (1..5).each do |i|
        @daily_reports << DailyReport.new(
          title: "example_title#{i}",
          content: "example_content#{i}",
          mood: i % 3,
          user:
        )
      end
    end
  end
end
