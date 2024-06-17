class DailyReport < ApplicationRecord
  belongs_to :user
  has_many :learned_tags, through: :daily_reports_learned_tags
  has_many :thumbs_ups
  has_many :liked_users, through: :thumbs_ups, source: :user

  enum :mood, [ :normal, :fun, :productive, :sleepy, :unwell ]
end
