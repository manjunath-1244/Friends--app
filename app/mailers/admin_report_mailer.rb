class AdminReportMailer < ApplicationMailer
  default from: "no-reply@friendsapp.com"

  def daily_report(admin)
    @admin = admin
    @users_count = User.count
    @posts_count = Post.count
    @friends_count = Friend.count

    mail(
      to: @admin.email,
      subject: "Daily Application Activity Report"
    )
  end
end
