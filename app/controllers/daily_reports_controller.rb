class DailyReportsController < ApplicationController
  load_and_authorize_resource

  def index
    @daily_reports = @daily_reports.includes(:user, :learned_tags, :thumbs_ups).order(created_at: :desc).page(params[:page])
  end

  def show
    @comments = @daily_report.comments.includes(:user)
  end

  def new; end

  def edit; end

  def create
    @daily_report.user = current_user
    if @daily_report.save
      register_learned_tags
      redirect_to daily_report_url(@daily_report), notice: '日報が作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @daily_report.update(daily_report_params)
      register_learned_tags
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

  def register_learned_tags
    learned_tags = params[:learned_tags].split(/[,、]/)
                                        .map { |learned_tag| learned_tag.strip.downcase }
                                        .reject(&:empty?)
                                        .uniq
    current_learned_tags = @daily_report.learned_tags.pluck(:name)

    add_new_learned_tags(learned_tags, current_learned_tags)
    remove_old_learned_tags(learned_tags, current_learned_tags)
  end

  def add_new_learned_tags(learned_tags, current_learned_tags)
    new_learned_tags = learned_tags - current_learned_tags
    new_learned_tags.each do |learned_tag|
      tag = LearnedTag.find_or_create_by(name: learned_tag)
      @daily_report.learned_tags << tag
    end
  end

  def remove_old_learned_tags(learned_tags, current_learned_tags)
    old_learned_tags = current_learned_tags - learned_tags
    old_learned_tags.each do |learned_tag|
      tag = LearnedTag.find_by(name: learned_tag)
      @daily_report.learned_tags.destroy(tag)
    end
  end
end
