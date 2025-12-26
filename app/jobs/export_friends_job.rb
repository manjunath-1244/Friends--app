require "csv" 
class ExportFriendsJob < ApplicationJob
  queue_as :default

  def perform(admin_id)
    admin = User.find(admin_id)

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["First Name", "Last Name", "Email", "Phone", "Owner Email"]

      Friend.includes(:user).find_each do |friend|
        csv << [
          friend.first_name,
          friend.last_name,
          friend.email,
          friend.phone,
          friend.user.email
        ]
      end
    end

    AdminExportMailer.send_csv(
      admin,
      csv_data,
      "friends_list.csv"
    ).deliver_now
  end
end
