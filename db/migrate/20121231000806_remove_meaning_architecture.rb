class RemoveMeaningArchitecture < ActiveRecord::Migration
  def up

    remove_column :words,       :freq, :meaning_id
    remove_column :list_items,         :meaning_id

    add_column    :list_items, :word1_id, :integer
    add_column    :list_items, :word2_id, :integer

  end

  def down

    remove_column :list_items, :word1_id, :word2_id

    add_column :words,      :freq,       :integer, :default => 0
    add_column :words,      :meaning_id, :integer

    add_column :list_items, :meaning_id, :integer

  end
end
