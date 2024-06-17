class CreateDailyReportsLearnedTags < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_reports_learned_tags do |t|
      t.references :daily_report, null: false, foreign_key: true
      t.references :learned_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
