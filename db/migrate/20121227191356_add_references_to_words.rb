class AddReferencesToWords < ActiveRecord::Migration
  def change
    add_column :words, :language_id, :integer
    add_column :words, :meaning_id, :integer
  end
end
