class Public::UnsubscribesController < Public::CustomerSite::BaseController
  def show
    @contact = GlobalID::Locator.locate_signed(params[:id], for: :unsubscribe)
    @contact.update(email_subscriber: false)
  end
end
