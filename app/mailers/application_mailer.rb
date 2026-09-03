class ApplicationMailer < ActionMailer::Base
  default from: -> {
    address = ENV.fetch("SMTP_FROM_ADDRESS", ENV.fetch("MAIL_FROM", "no-reply@maydecemberclub.com"))
    name = ENV["SMTP_FROM_NAME"].presence
    name ? Mail::Address.new(address).tap { |mail_address| mail_address.display_name = name }.format : address
  }
  layout false
end
