class Public::SubscribesController < Public::CustomerSite::BaseController
  before_action :set_contact, only: %i[ show edit update destroy ]

layout "customer_support"
  def index
    @contacts =Contact.all
  end
  
  def show
  end

  def new
    @contact = Contact.new
  end
  
  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.email_subscriber = true


    respond_to do |format|
      if @contact.save
        format.html { redirect_to "/", notice: "Subscription was successfully created." }
      else
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find_by(email: params[:email])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :email)
    end
end
