class AdminReportService
  def self.send_reports
    User.where(role: "admin").find_each do |admin|
      AdminReportMailer.daily_report(admin).deliver_now
    end
  end
end
