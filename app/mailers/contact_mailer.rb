class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.notification.subject
  #
  def notification
    @contact          = params[:contact]
    @unsubscribe_url = unsubscribe_url(@contact.to_sgid(for: :unsubscribe))
    # @base_domain      = @contact.site.domain
    @greeting = "Hi"

    headers[List-Unsubscribe] = "<#{@unsubscribe_url}>"
    mail to: @contact.email
  end
end
