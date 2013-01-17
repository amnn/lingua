require 'digest/md5'

class TestsController < ApplicationController

  # GET tests/from/1
  # GET tests/to/1
  def test

    @list = List.find( params[:id] )

    respond_to do |format|
      if @list.public || @list.user == current_user
        format.html
      else
        format.html { redirect_to lists_url, alert:  "You cannot take that test" }
      end
    end

  end

  def update

    item     = ListItem.find( params[ :item_id ] )
    @correct = ( params[ :ans ] == 1 ? item.word1_str : item.word2_str ).downcase
    list     = item.list

    respond_to do |format|
      if list.public || list.user == current_user

        format.json { render 'update' }

      else

        format.json { head :no_content, status: :unauthorized_access }

      end
    end

  end
end
