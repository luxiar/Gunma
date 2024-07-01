module ApplicationHelper
  def admin_edit_other_user?(user)
    current_user.admin? && current_user != user
  end

  def index_path
    case controller_name
    when 'daily_reports'
      daily_reports_path
    when 'users'
      users_path
    else
      root_path
    end
  end
end
