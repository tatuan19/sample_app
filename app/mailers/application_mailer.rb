class ApplicationMailer < ActionMailer::Base
  default from: ENV["mail_default"]
  layout "mailer"
end
