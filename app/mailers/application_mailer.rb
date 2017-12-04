class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer.default
  layout "mailer"
end
