class AddReferencesToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :meaning_id, :integer
    add_column :list_items, :list_id, :integer
  end
end
