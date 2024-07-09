class CreateDailyReports < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_reports do |t|
      t.string :title, null: false
      t.integer :mood, default: 0
      t.references :user, null: false, foreign_key: true
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
