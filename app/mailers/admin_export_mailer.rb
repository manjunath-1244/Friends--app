
class AdminExportMailer < ApplicationMailer
  def send_csv(admin, csv_data, filename)
    attachments[filename] = csv_data

    mail(
      to: admin.email,
      subject: "Your CSV Export is Ready"
    )
  end
end
