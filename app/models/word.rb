class Word < ActiveRecord::Base
  attr_accessible :freq, :word

  belongs_to :language
  belongs_to  :meaning

end
