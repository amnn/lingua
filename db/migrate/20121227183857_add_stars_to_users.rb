class AddStarsToUsers < ActiveRecord::Migration
  def change

    add_column :users, :stars, :integer

  end
end
