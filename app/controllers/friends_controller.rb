class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
  end

  def show
    @friend = current_user.friends.find(params[:id])
  end

  def new
    @friend = current_user.friends.build
  end

  def create
    @friend = current_user.friends.build(friend_params)

    if @friend.save
      redirect_to friends_path, notice: "Friend added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @friend = current_user.friends.find(params[:id])
  end

  def update
    @friend = current_user.friends.find(params[:id])

    if @friend.update(friend_params)
      redirect_to friends_path, notice: "Friend updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @friend = current_user.friends.find(params[:id])
    @friend.destroy
    redirect_to friends_path, notice: "Friend deleted."
  end

  private

  def friend_params
    params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter)
  end
end
