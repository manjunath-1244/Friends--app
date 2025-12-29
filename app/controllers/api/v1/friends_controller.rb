class Api::V1::FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.admin? ? Friend.includes(:user) : current_user.friends
  end

  def show
    @friend = Friend.find(params[:id])
  end
end


# http://localhost:3000/api/v1/friends.json    use this url for friends json data