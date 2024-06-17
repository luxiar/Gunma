class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :daily_report, null: false, foreign_key: true
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
