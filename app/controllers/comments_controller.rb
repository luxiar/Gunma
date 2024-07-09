class CommentsController < ApplicationController
  before_action :set_daily_report

  def create
    comment = @daily_report.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      render partial: 'daily_reports/comments_form', locals: { daily_report: @daily_report, comments: @daily_report.comments.includes(:user) }
    else
      redirect_to @daily_report, alert: 'コメントの投稿に失敗しました'
    end
  end

  def destroy
    comment = @daily_report.comments.find(params[:id])

    if comment.destroy
      render partial: 'daily_reports/comments', locals: { comments: @daily_report.comments.includes(:user) }
    else
      redirect_to @daily_report, alert: 'コメントの削除に失敗しました'
    end
  end

  private

  def set_daily_report
    @daily_report = DailyReport.find(params[:daily_report_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
