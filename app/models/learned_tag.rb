class LearnedTag < ApplicationRecord
  has_many :daily_report, through: :daily_reports_learned_tags

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['daily_report']
  end
end
