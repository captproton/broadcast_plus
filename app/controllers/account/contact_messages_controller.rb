class Account::ContactMessagesController < Account::ApplicationController
  account_load_and_authorize_resource :contact_message, through: :site, through_association: :contact_messages

  # GET /account/sites/:site_id/contact_messages
  # GET /account/sites/:site_id/contact_messages.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/contact_messages/:id
  # GET /account/contact_messages/:id.json
  def show
  end

  # GET /account/sites/:site_id/contact_messages/new
  def new
  end

  # GET /account/contact_messages/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/contact_messages
  # POST /account/sites/:site_id/contact_messages.json
  def create
    respond_to do |format|
      if @contact_message.save
        format.html { redirect_to [:account, @site, :contact_messages], notice: I18n.t("contact_messages.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @contact_message] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/contact_messages/:id
  # PATCH/PUT /account/contact_messages/:id.json
  def update
    respond_to do |format|
      if @contact_message.update(contact_message_params)
        format.html { redirect_to [:account, @contact_message], notice: I18n.t("contact_messages.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @contact_message] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/contact_messages/:id
  # DELETE /account/contact_messages/:id.json
  def destroy
    @contact_message.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :contact_messages], notice: I18n.t("contact_messages.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_message_params
    strong_params = params.require(:contact_message).permit(
      :email,
      :first_name,
      :last_name,
      :phone,
      :subject,
      :body,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
