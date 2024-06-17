class CreateLearnedTags < ActiveRecord::Migration[7.1]
  def change
    create_table :learned_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
