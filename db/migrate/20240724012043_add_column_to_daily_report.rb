class AddColumnToDailyReport < ActiveRecord::Migration[7.1]
  def change
    add_column :daily_reports, :thumbs_ups_count, :integer
  end
end
