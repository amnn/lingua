class AddReferencesToListRating < ActiveRecord::Migration
  def change
    add_column :list_ratings, :user_id, :integer
    add_column :list_ratings, :list_id, :integer
  end
end
