class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.boolean :admin, default: false
      t.timestamp :deleted_at

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
