class LearnedTag < ApplicationRecord
  has_many :daily_report, through: :daily_reports_learned_tags

  def self.ransackable_attributes(auth_object = nil)
    ['name']
  end
end
