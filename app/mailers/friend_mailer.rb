class FriendMailer < ApplicationMailer
  def friend_added(user, friend)
    @user = user
    @friend = friend

    mail(
      to: @user.email,
      subject: "New friend added successfully 🎉"
    )
  end
end

