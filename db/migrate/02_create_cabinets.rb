class CreateCabinets < ActiveRecord::Migration
  def change
    create_table :cabinets do |t|
      t.string :name
      t.integer :capacity
      t.integer :user_id
    end
  end
end
