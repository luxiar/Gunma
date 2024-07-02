class DailyReportsController < ApplicationController
  load_and_authorize_resource

  def index
    @daily_reports = @daily_reports.includes(:user).includes(:learned_tags).order(created_at: :desc)

    filter_daily_reports

    @daily_reports = @daily_reports.page(params[:page])
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
    learned_tags = params[:daily_report][:learned_tags].split(/,|、/)
                                                       .map { |tag| tag.gsub(/\s+/, '') }
                                                       .reject(&:empty?)
                                                       .map { |tag| tag.match?(/A-Z/) ? tag.downcase : tag }
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
      @daily_report.learned_tags.delete(tag)
    end
  end

  def filter_daily_reports
    @filters = []
    return if params[:filter].blank?

    filtered_params = params.require(:filter).permit(:user_id, :learned_tag_id)

    if filtered_params[:user_id].present?
      user = User.find_by(id: filtered_params[:user_id])
      if user
        @daily_reports = @daily_reports.where(user_id: user.id)
        @filters << "ユーザー: #{user.full_name}"
      end
    end

    if filtered_params[:learned_tag_id].present?
      learned_tag = LearnedTag.find_by(id: filtered_params[:learned_tag_id])
      if learned_tag
        @daily_reports = @daily_reports.joins(:learned_tags).where(learned_tags: { id: learned_tag.id }).distinct
        @filters << "タグ: #{learned_tag.name}"
      end
    end
  end
end
