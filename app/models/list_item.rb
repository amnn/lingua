class ListItem < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :meaning
  belongs_to    :list

end
