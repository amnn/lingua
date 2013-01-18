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

    milestones = {

      0.days  => 3,
      1.day   => 5,
      1.week  => 7,
      2.weeks => 8,
      1.month => 9

    }

    parCorr   =                       params[ :correct ] == "true"
    item      =               ListItem.find( params[ :item_id ] )
    to        =                               params[ :ans ] == 1
    @correct  = ( to ? item.word1_str : item.word2_str ).downcase
    list      =                                         item.list

    user_word = UserWord.where( user_id:                    current_user.id, 
                                lang_id: to ? list.lang2.id : list.lang1.id,
                                word_id: to ? item.word1_id : item.word2_id ).
                         first_or_initialize( progress:                   0, 
                                              correct:                    0, 
                                              last_updated:        Time.now,
                                              wrong:               !parCorr )

    timeDiff  =                           Time.now - user_word.last_updated
    nextMS    =                         milestones.keys[ user_word.progress ]

    if user_word.progress > 0   &&
      !user_word.wrong          && 
      !parCorr                then 

      user_word.progress -= 1
      current_user.stars -= 1 

    end

    user_word.wrong = !parCorr

    if parCorr && timeDiff >= nextMS

      user_word.correct += 1

      if user_word.correct >= milestones[ nextMS ] then

        user_word.progress += 1 
        current_user.stars += 1

      end

    end

    respond_to do |format|
      if ( list.public || list.user == current_user ) && user_word.save && current_user.save

        format.json { render 'update' }

      else

        format.json { head :no_content, status: :unauthorized_access }

      end
    end

  end
end
