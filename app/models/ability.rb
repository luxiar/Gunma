# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    # 日報
    # 退社してたら閲覧のみ可能
    can :read, DailyReport

    if user.active?
      # ログインしていれば閲覧、作成可能
      can :create, DailyReport
      # 自分のもののみ編集、削除可能
      can %i[update destroy], DailyReport, user_id: user.id
    end

    # ユーザー情報
    # 退社してたら閲覧のみ可能
    can %i[read retired all], User

    # 入社してたら自分を編集可能
    can :update, User, id: user.id if user.active?

    # 管理者は全て許可
    can :manage, :all if user.admin?
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
