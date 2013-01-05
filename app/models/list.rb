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
                                allow_destroy:         true

  def self.filter params, curr_user

    base_query  = []
    base_params = [] 

    if params[     :my_lists ]

      base_query  << "user_id = ?"
      base_params <<  curr_user.id

    end

    if params[ :public_lists ]

      base_query  << "public = ?"
      base_params <<         true

    end

    lists_base    = List.where( base_query.join( " OR " ), *base_params )

    filter_query  = []
    filter_params = []

    if params[ :search ]

      filter_query  <<              "name LIKE ?"
      filter_params << "%#{ params[ :search ] }%" 

    end

    if params[ :lang ]

      lang_ids = params[ :lang ].collect { |id, on| id.to_i }
      in_list  = "(#{ ( ['?'] * lang_ids.count ).join(',') })"

      filter_query  << "(lang1_id IN #{in_list} OR lang2_id IN #{in_list} )"
      filter_params += lang_ids * 2

    end

    lists_base.where( filter_query.join( " AND " ), *filter_params )
  end

end
