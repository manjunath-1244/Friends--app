class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  def index
  @friends =
    if current_user.admin?
      Friend.all
    else
      current_user.friends
    end

  if params[:query].present?
    search = "%#{params[:query]}%"
    @friends = @friends.where(
      "first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?",
      search, search, search
    )
  end

  @friends = @friends.page(params[:page]).per(10)
end


  def show
    # @friend is already set by set_friend
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
    # @friend is already set by set_friend
  end

  def update
    if @friend.update(friend_params)
      redirect_to friends_path, notice: "Friend updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @friend.destroy
    redirect_to friends_path, notice: "Friend deleted."
  end

  private

  def set_friend
    @friend = if current_user.admin?
                Friend.find(params[:id])
              else
                current_user.friends.find(params[:id])
              end
  end

  def friend_params
    params.require(:friend).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :twitter,
      :avatar
    )
  end
end
