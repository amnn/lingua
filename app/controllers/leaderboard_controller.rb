class LeaderboardController < ApplicationController

  def index

    @users = User.order( 'stars DESC' ).limit( 50 )

  end

end
