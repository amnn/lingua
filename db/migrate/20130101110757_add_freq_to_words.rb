class AddFreqToWords < ActiveRecord::Migration
  def change
    add_column :words, :freq, :integer, :default => 1
  end
end
