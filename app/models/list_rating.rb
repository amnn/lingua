class ListRating < ActiveRecord::Base
  attr_accessible :rating, :user, :list
  attr_accessible :user_id, :user_list

  belongs_to :user
  belongs_to :list
end
