class ChangeLastUpdatedColumnInUserWords < ActiveRecord::Migration
  def up

    change_column :user_words, :last_updated, :datetime

  end

  def down

    change_column :user_words, :last_updated, :date
    
  end
end
