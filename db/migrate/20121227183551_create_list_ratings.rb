class CreateListRatings < ActiveRecord::Migration
  def change
    create_table :list_ratings do |t|
      t.integer :rating

      t.timestamps
    end
  end
end
