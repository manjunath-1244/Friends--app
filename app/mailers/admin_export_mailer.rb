

class AdminExportMailer < ApplicationMailer
  def send_csv(admin, csv_data, filename)
    attachments[filename] = {
      mime_type: "text/csv",
      content: csv_data
    }

    mail(
      to: admin.email,
      subject: "Your CSV Export is Ready",
      body: <<~BODY
        Hello #{admin.email},

        Your requested CSV export is ready.
        Please find the attached file: #{filename}

        Thanks,
        Friends App
      BODY
    )
  end
end

# Background Job