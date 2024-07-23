class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :daily_report

  validates :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ['content']
  end
end
