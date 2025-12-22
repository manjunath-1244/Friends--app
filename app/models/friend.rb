class Friend < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  #Validation
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { scope: :user_id }
    # callback
  after_commit :send_friend_added_email, on: :create

  private

  def send_friend_added_email
    
    FriendMailer.friend_added(user, self).deliver_now
    
  end
end
