class List < ActiveRecord::Base
  attr_accessible :lang1, :lang2, :name

  has_many :list_items
end
