class CreateThumbsUps < ActiveRecord::Migration[7.1]
  def change
    create_table :thumbs_ups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :daily_report, null: false, foreign_key: true

      t.timestamps
    end
  end
end
