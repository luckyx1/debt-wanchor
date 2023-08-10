class CreateUser < ActiveRecord::Migration[7.0]
  def up 
    create_table :users do |t|
      t.string :name, null: false
      t.integer :debt, default: 0, null: false

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
