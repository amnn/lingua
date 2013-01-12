class List < ActiveRecord::Base  
  
  paginates_per 20

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

  def rating

    count = list_ratings.size

    count == 0 ? 0 : ( list_ratings.map( &:rating ).inject( 0, &:+ ) / count ).round

  end

  def self.filter params, curr_user

    base_query    = []
    base_params   = [] 
    filter_query  = []
    filter_params = []

    if params[     :my_lists ]

      base_query  << "lists.user_id = ?"
      base_params <<        curr_user.id

    end

    if params[ :public_lists ]

      base_query  << "lists.public = ?"
      base_params <<               true

    end

    if params[ :search ]

      filter_query  <<        "lists.name LIKE ?"
      filter_params << "%#{ params[ :search ] }%" 

    end

    if params[ :lang ]

      lang_ids = params[ :lang ].collect { |id, on| id.to_i }
      in_list  = "(#{ ( ['?'] * lang_ids.count ).join(',') })"

      filter_query  << "(lists.lang1_id IN #{in_list} OR lists.lang2_id IN #{in_list} )"
      filter_params += lang_ids * 2

    end

    lists_base = List.where(  base_query.join(   " OR " ),   *base_params ).
                      where( filter_query.join( " AND " ), *filter_params )

    d = params[ :dir ].upcase

    case params[ :sortBy ]
    when "public", "name", "updated_at"

      lists_base.order(               params[:sortBy] + " " + d )

    when "created_by"

      lists_base.joins( :user ).order(  "users.first_name " + d )

    when "languages"

      lists_base.joins( "INNER JOIN languages AS lang1 ON lists.lang1_id = lang1.id" ).
                 joins( "INNER JOIN languages AS lang2 on lists.lang2_id = lang2.id" ).
                 order(                      'lang1.name ' + d + ', lang2.name ' + d )

    when "rating"

      lists_base.joins( "LEFT JOIN list_ratings ON list_ratings.list_id = lists.id" ).
                 group(                                                  "lists.id" ).
                 order(                           "AVG( list_ratings.rating ) " + d )

    else
      lists_base
    end

  end

end
