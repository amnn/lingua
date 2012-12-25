class Meaning < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many     :words
  has_many :list_item
  
end
