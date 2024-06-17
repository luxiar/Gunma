class User < ApplicationRecord
  has_many :daily_reports, dependent: :destroy
  has_many :thumbs_ups, dependent: :destroy
  has_many :like_daily_reports, through: :thumbs_ups, source: :daily_report
  has_many :comments, dependent: :destroy
end