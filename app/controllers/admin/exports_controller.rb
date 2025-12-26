class Admin::ExportsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
  end

  def friends
    ExportFriendsJob.perform_later(current_user.id)
    redirect_to admin_exports_path,
                notice: "Friends CSV export started. You will receive an email."
  end

  def posts
    ExportPostsJob.perform_later(current_user.id)
    redirect_to admin_exports_path,
                notice: "Posts CSV export started. You will receive an email."
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
