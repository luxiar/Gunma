class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :password
      t.boolean :admin
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
