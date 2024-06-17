class DailyReport < ApplicationRecord
  belongs_to :user
  has_many :learned_tags, through: :daily_reports_learned_tags
  has_many :thumbs_ups, dependent: :destroy
  has_many :liked_users, through: :thumbs_ups, source: :user
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user

  enum :mood, %i[normal fun productive sleepy unwell]
end