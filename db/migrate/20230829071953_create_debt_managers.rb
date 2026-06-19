class CreateDebtManagers < ActiveRecord::Migration[7.0]
  def up 
    create_table :debt_managers do |t|
      t.integer :challenger_id
      t.integer :challengee_id
      t.integer :debt_amount

      t.timestamps
    end
  end

  def down
    drop_table :debt_managers
  end
end
