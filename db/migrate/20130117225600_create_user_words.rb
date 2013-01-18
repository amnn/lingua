class CreateUserWords < ActiveRecord::Migration
  def change
    create_table :user_words do |t|
      t.integer :user_id
      t.integer :word_id
      t.integer :lang_id
      t.integer :progress
      t.integer :correct
      t.boolean :wrong
      t.date :last_updated

      t.timestamps
    end
  end
end
