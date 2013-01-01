class List < ActiveRecord::Base
  attr_accessible :lang1, :lang2, :name, :user, :public, :lang1_id, :lang2_id

  validates :user_id, :lang1_id, :lang2_id, :name, :presence => true

  belongs_to        :lang1, :class_name => 'Language'
  belongs_to        :lang2, :class_name => 'Language'

  belongs_to         :user
  has_many     :list_items
  has_many   :list_ratings
end
