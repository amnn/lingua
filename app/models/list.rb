class List < ActiveRecord::Base
  attr_accessible :lang1, :lang2, :name

  belongs_to         :user
  has_many     :list_items
  has_many   :list_ratings
end
