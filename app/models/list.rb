class List < ActiveRecord::Base  
  
  attr_accessible                  :user
  attr_accessible       :name,   :public
  attr_accessible      :lang1,    :lang2
  attr_accessible   :lang1_id, :lang2_id
  attr_accessible :list_items_attributes

  validates :user_id, :lang1_id, :lang2_id, :name, presence: true

  belongs_to :lang1, class_name: 'Language'
  belongs_to :lang2, class_name: 'Language'

  belongs_to                         :user

  has_many                     :list_items,
                     dependent:   :destroy

  has_many                   :list_ratings

  accepts_nested_attributes_for                 :list_items, 
                                allow_destroy:         true, 
                                reject_if:     lambda { |a| 
                                    a[:word1_str].blank? || 
                                    a[:word2_str].blank?  }

end
