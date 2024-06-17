class DailyReport < ApplicationRecord
  belongs_to :user
  belongs_to :mood
  has_many :learned_tags, through: :daily_reports_learned_tags
end
