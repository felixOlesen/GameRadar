class ApplicationMailer < ActionMailer::Base
  default to: "info@gameRadar.com", from: "info@gameRadar.com"
  layout 'mailer'
end
