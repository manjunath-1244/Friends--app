class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friends, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

#   def friends_with?(other_user)
#   friends.exists?(id: other_user.id)
# end


  def admin?
    role == "admin"
  end


  
  def full_name
    first_name.presence || email
  end

  validates :email,
    presence: true,
    format: { 
      with: URI::MailTo::EMAIL_REGEXP,
      message: "is not a valid email"
    }
    # validates :twitter,
    # allow_blank: true,
    # format: {
    #   with: /\A@?[A-Za-z0-9_]{1,15}\z/,
    #   message: "must be a valid Twitter username"
    # }

  
end
