class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.integer :user_id
      t.string :link
      t.string :type
      t.string :value

      t.timestamps
    end
    #might not be right
    add_index :things, :user_id
  end
end
