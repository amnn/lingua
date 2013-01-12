class ListsController < ApplicationController

  before_filter :authenticate_user!

  def item_blank? a

      a["word1_str"].blank? || a["word2_str"].blank?

  end

  # GET /lists
  # GET /lists.json
  def index

    # Set Filter defaults

    if params[     :my_lists ].nil?   &&
       params[ :public_lists ].nil? then

      params[      :my_lists ] =  true

    end

    if params[ :lang ].nil?

      params[  :lang ] = Hash[ Language.all.map { |l| [l.id.to_s, "1"] } ]

    end

    if params[ :sortBy ].nil?

      params[ :sortBy ] = 'name'
      params[    :dir ] =  'asc'

    end

    @lists = List.filter( params, current_user ).page( params[:page] || 1 )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list = List.find(params[:id])

    respond_to do |format|

      if !@list.public && @list.user != current_user

        format.html { redirect_to lists_url, alert:  "You cannot view that list" }
        format.json { head :no_content,      status:               :unauthorized }

      else
        format.html # show.html.erb
        format.json { render json: @list }
      end

    end
  end

  # GET /lists/new
  # GET /lists/new.json
  def new
    @list = List.new

    @list.list_items.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list }
    end
  end

  # PUT /lists/1/rate?score=5
  def rate

    list   = List.find( params[ :id ] )
    score  = params[         :score ]

    if !score.nil?
      puts "UPDATING SCORE"
      rating        = ListRating.where( list_id:         list.id, 
                                        user_id: current_user.id ).first_or_create

      rating.rating = score

    end


    respond_to do |format|

      if score.nil? || !rating.save

        format.html { redirect_to request.referer, alert:  "Invalid rating provided for list." }
        format.json { head            :no_content, status:                         :unassigned }

      else

        format.html { redirect_to request.referer, notice: "Rated #{ list.name } #{ score } out of 5!" }
        format.json { head            :no_content, status:                                         :ok }

      end

    end
  end

  # POST /lists/1/copy
  def copy

    copy_list = List.find(         params[ :id ] )

    @list     = List.new( name:    copy_list.name,
                          lang1:  copy_list.lang1,
                          lang2:  copy_list.lang2,
                          public:           false,
                          user:      current_user )

    items = copy_list.list_items.map do |fields|

      ListItem.new( list:                 @list, 
                    word1_str: fields.word1_str, 
                    word2_str: fields.word2_str )

    end

    if @list.save && items.map( &:save ).all?

      redirect_to action: 'show', id: @list.id

    else

      redirect_to lists_url, alert: 'There was an error copying the list.'

    end

  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])

    if @list.user != current_user

      redirect_to lists_url, alert: "You cannot edit that list."

    end
  end

  # POST /lists
  # POST /lists.json
  def create

    nested     = params[:list].delete(:list_items_attributes)

    @list      =                    List.new( params[:list] )
    @list.user =                               current_user

    records    = nested.collect do |_, fields| 

      ListItem.new(     { "list" => @list }.merge( fields ) ) if !item_blank?( fields )

    end.compact

    respond_to do |format|
      if @list.save && records.map( &:save ).all?

        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render json: @list, status: :created, location: @list }

      else

        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }

      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.json
  def update
    @list     = List.find(params[:id])

    nested    = params[:list].delete( :list_items_attributes )

    new_items = []

    if nested then
      nested.each do |i, r|

        if !r.key?( "id" )

          new_items << ListItem.new( { "list" => @list }.merge( r ) ) if !item_blank?( r )

          nested.delete( i )

        else

          r[ "_destroy" ] = "true" if item_blank?( r )

        end

      end
    end

    respond_to do |format|
      if @list.update_attributes(                       params[ :list ] )   && 
         @list.update_attributes( list_items_attributes: (nested || {}) )   &&
         new_items.map(                                     &:save ).all? then

        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { head :no_content }

      else

        format.html { render action: "edit" }
        format.json { render json: @list.errors, status: :unprocessable_entity }

      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list = List.find(params[:id])

    respond_to do |format|

      if @list.user == current_user

        @list.destroy

        format.html { redirect_to   lists_url }
        format.json { head        :no_content }

      else

        format.html { redirect_to lists_url, alert: "You cannot delete that list" }
        format.json { head :no_content,      status:                :unauthorized }

      end

    end
  end
end
