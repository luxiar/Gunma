class LearnedTag < ApplicationRecord
  has_many :daily_report, through: :daily_reports_learned_tags
end
