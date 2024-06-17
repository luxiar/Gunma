class DailyReport < ApplicationRecord
  belongs_to :user
  has_many :learned_tags, through: :daily_reports_learned_tags

  enum :mood, [ :normal, :fun, :productive, :sleepy, :unwell ]
end
