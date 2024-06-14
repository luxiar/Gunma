class CreateDailyReports < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_reports do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :mood, null: false, foreign_key: true

      t.timestamps
    end
  end
end
