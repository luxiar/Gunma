class DeleteColumnDeletedAt < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :deleted_at, :timestamp
    remove_column :daily_reports, :deleted_at, :timestamp
    remove_column :comments, :deleted_at, :timestamp
    remove_column :learned_tags, :deleted_at, :timestamp

    add_column :users, :active, :boolean, default: true, null: false
  end
end
