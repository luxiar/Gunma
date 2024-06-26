module ApplicationHelper
  def admin_edit_other_user?(user)
    current_user.admin? && current_user != user
  end
end
