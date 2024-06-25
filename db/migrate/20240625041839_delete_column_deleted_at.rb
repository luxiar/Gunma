class DeleteColumnDeletedAt < ActiveRecord::Migration[7.1]
  def up
    remove_column :users, :deleted_at
    remove_column :daily_reports, :deleted_at
    remove_column :comments, :deleted_at
    remove_column :learned_tags, :deleted_at

    add_column :users, :status, :integer, default: 0, null: false
  end

  def down
    add_column :users, :deleted_at, :timestamp
    add_column :daily_reports, :deleted_at, :timestamp
    add_column :comments, :deleted_at, :timestamp
    add_column :learned_tags, :deleted_at, :timestamp

    remove_column :users, :status
  end
end
