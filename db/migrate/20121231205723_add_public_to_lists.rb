class AddPublicToLists < ActiveRecord::Migration
  def change
    add_column :lists, :public, :boolean
  end
end
