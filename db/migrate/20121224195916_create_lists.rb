class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.string :lang1
      t.string :lang2

      t.timestamps
    end
  end
end
