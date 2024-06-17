class User < ApplicationRecord
  has_many :daily_reports
  has_many :thumbs_ups
  has_many :like_daily_reports, through: :thumbs_ups, source: :daily_report
end
