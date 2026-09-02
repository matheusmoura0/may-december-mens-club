class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAIL_FROM", "no-reply@maydecemberclub.com")
  layout false
end
