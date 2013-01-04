class Word < ActiveRecord::Base
  attr_accessible :freq, :word, :language, :language_id

  belongs_to :language

  has_many                    :items1, 
           :foreign_key =>    'word1', 
           :class_name  => 'ListItem'

  has_many                    :items2,
           :foreign_key =>    'word2',
           :class_name  => 'ListItem'

  has_many :lists, :through => :items

  def items

    items1 + items2

  end



end
