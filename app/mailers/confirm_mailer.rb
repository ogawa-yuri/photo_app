class ConfirmMailer < ApplicationMailer
  # default from: 'notifications@example.com'
  def confirm_mail(photo)
    @user = photo.user
    @content = photo
    mail to: @user.email, subject: "投稿完了のお知らせ"
  end
end
