class ListsController < ApplicationController

  before_filter :authenticate_user!

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all

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
      format.html # show.html.erb
      format.json { render json: @list }
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

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
  end

  # POST /lists
  # POST /lists.json
  def create

    nested     = params[:list].delete(:list_items_attributes)

    @list      =                    List.new( params[:list] )
    @list.user =                               current_user

    records    = nested.collect do |_, fields| 

      ListItem.new(     { "list" => @list }.merge( fields ) )

    end

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

    nested.delete_if do |i, r|

      new_items << ListItem.new( { "list" => @list }.merge( r ) ) if !r.key?( "id" ) 

      !r.key?( "id" )
    end

    respond_to do |format|
      if @list.update_attributes(               params[ :list ] )   && 
         @list.update_attributes( list_items_attributes: nested )   &&
         new_items.map(                             &:save ).all? then

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
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url }
      format.json { head :no_content }
    end
  end
end
