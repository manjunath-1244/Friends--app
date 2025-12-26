require "csv" 
class ExportPostsJob < ApplicationJob
  queue_as :default

  def perform(admin_id)
    admin = User.find(admin_id)

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["Post Content", "User Email", "Created At"]

      Post.includes(:user).find_each do |post|
        csv << [
          post.content,
          post.user.email,
          post.created_at
        ]
      end
    end

    AdminExportMailer.send_csv(
      admin,
      csv_data,
      "posts_list.csv"
    ).deliver_now
  end
end
