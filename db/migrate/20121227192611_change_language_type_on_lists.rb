class ChangeLanguageTypeOnLists < ActiveRecord::Migration
  def up

    add_column    :lists, :lang1_id, :integer
    add_column    :lists, :lang2_id, :integer

    remove_column :lists,              :lang1
    remove_column :lists,              :lang2

  end

  def down

    add_column    :lists, :lang1, :string
    add_column    :lists, :lang2, :string

    remove_column :lists,       :lang1_id
    remove_column :lists,       :lang2_id


  end
end
