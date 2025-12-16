class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @total_users   = User.count
    @total_friends = Friend.count

    @friends_per_user = User
      .left_joins(:friends)
      .group("users.id")
      .select("users.email, COUNT(friends.id) AS friends_count")
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end

