class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.string :rec_type
      t.string :rec_description
      t.string :link

      t.timestamps
    end
  end
end
