class CreateLearnedTags < ActiveRecord::Migration[7.1]
  def change
    create_table :learned_tags do |t|
      t.string :name, null: false
      t.timestamp :deleted_at

      t.timestamps
    end

    add_index :learned_tags, :name, unique: true
  end
end
