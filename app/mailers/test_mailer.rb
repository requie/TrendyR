class TestMailer < Devise::Mailer
  # Action to test mailing manually
  # Call from rails console with:
  #
  #   TestMailer.test('your-email@example.com').deliver
  #
  def test(email)
    mail(to: email, subject: 'This is a test mail')
  end
end
