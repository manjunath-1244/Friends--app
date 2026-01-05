class AdminReportMailer < ApplicationMailer
  default from: "manjunath@bitcot.com"

  def daily_report(admin)
    @admin = admin
    @users_count = User.count
    @posts_count = Post.count
    @friends_count = Friend.count

    mail(
      to: @admin.email,
      subject: "Hi your Application Activity Report"
    )
  end
end

# Cron Job