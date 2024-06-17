class DailyReportsLearnedTag < ApplicationRecord
  belongs_to :daily_report
  belongs_to :learned_tag
end
