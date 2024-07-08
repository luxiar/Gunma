class DailyReportsController < ApplicationController
  load_and_authorize_resource

  def index
    @daily_reports = @daily_reports.includes(:user).order(created_at: :desc)

    filter_daily_reports

    @daily_reports = @daily_reports.preload(:learned_tags).page(params[:page])
  end

  def show; end

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

  def filter_daily_reports
    @filters = []
    return if params[:filter].blank?

    filtered_params = params.require(:filter).permit(:user_id, :learned_tag_id)

    filter_by_user(filtered_params[:user_id])
    filter_by_learned_tag(filtered_params[:learned_tag_id])
  end

  def filter_by_user(user_id)
    return if user_id.blank?

    user = User.find_by(id: user_id)
    return if user.blank?

    @daily_reports = @daily_reports.where(user_id: user.id)
    @filters << "ユーザー: #{user.full_name}"
  end

  def filter_by_learned_tag(learned_tag_id)
    return if learned_tag_id.blank?

    learned_tag = LearnedTag.find_by(id: learned_tag_id)
    return if learned_tag.blank?

    @daily_reports = @daily_reports.filter_by_learned_tag(learned_tag.id)
    @filters << "タグ: #{learned_tag.name}"
  end
end
