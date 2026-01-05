class Api::V1::FriendsController < Api::V1::BaseController
  # before_action :authenticate_user!

  def index
    
    @friends = current_user.admin? ? Friend.includes(:user) : current_user.friends
   

  end

  def show
    
    @friend = Friend.find(params[:id])
  end

    def create
    @friend = current_user.friends.build(friend_params)

    if @friend.save
      render :show, status: :created
    else
      render json: { errors: @friend.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def friend_params
    params.require(:friend).permit(:first_name, :last_name, :email, :phone)
  end
end




