class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :cabinet_id
      t.integer :user_id
    end
  end
end
