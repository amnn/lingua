class ListItem < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to                         :list
  belongs_to :word1, :class_name => 'Word'
  belongs_to :word2, :class_name => 'Word'

end
