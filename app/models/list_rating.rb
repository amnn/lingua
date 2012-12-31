class ListRating < ActiveRecord::Base
  attr_accessible :rating

  belongs_to :user
  belongs_to :list
end
