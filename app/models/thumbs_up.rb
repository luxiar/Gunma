class ThumbsUp < ApplicationRecord
  belongs_to :user
  belongs_to :daily_report, counter_cache: true
end
