class Public::ContactMessagesController < Public::CustomerSite::BaseController
  before_action :set_contact_message, only: %i[ show edit update destroy ]

    layout "frontdoor"

  # GET /contact_messages or /contact_messages.json
  def index

    @contact_messages = @site.contact_messages.all
    @contact_message  = @site.contact_messages.new
  end

  # GET /contact_messages/1 or /contact_messages/1.json
  def show
  end

  # GET /contact_messages/new
  def new
    @contact_message = @site.contact_messages.new
  end

  # GET /messages/1/edit
  # upon closer inspection you should see that we are actually using a POST method
  # it's a hack because turbo_streams don't support GET for retrieving the edit form
  def edit
    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: turbo_stream.update(@contact_message,
                                                 partial: "/public/contact_messages/form", 
                                                 locals: {contact_message: @contact_message})
      end
    end
  end

  # POST /contact_messages or /contact_messages.json
  def create
    @contact_message = @site.contact_messages.new(contact_message_params)

    respond_to do |format|
      if @contact_message.save
        
        format.turbo_stream do
          flash.now[:success] = "Contact message successfully sent!"
          render turbo_stream:  [
            turbo_stream.update('new_contact_message', 
                                  partial: "/public/contact_messages/form", 
                                  locals: {contact_message: ContactMessage.new}
                                ),
            turbo_stream.prepend('contact_messages', 
                                  partial: "/public/contact_messages/contact_message", 
                                  locals: {contact_message: @contact_message}
                                ),
            turbo_stream.update('contact_message_counter', html: ContactMessage.count.to_s),
            turbo_stream.update('contact_message_notice', "Contact message successfully sent!"),
            turbo_stream.update("flash", partial: "shared/notices")
          ]
        end
        format.html { redirect_to contact_messages_url, notice: "Contact message was successfully sent." }
        format.json { render :show, status: :created, location: @contact_message }
      else
        format.turbo_stream do
          render turbo_stream:  [
            turbo_stream.update('new_contact_message', 
                                  partial: "/public/contact_messages/form", 
                                  locals: {contact_message: @contact_message})
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact_messages/1 or /contact_messages/1.json
  def update
    respond_to do |format|
      if @contact_message.update(contact_message_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@contact_message, 
                                partial: "/public/contact_messages/contact_message", 
                                locals: {contact_message: @contact_message}),
            turbo_stream.update('contact_message_notice', 
                                "Contact message #{@contact_message.id} successfully updated!")
            
          ] 
        end
        format.html { redirect_to contact_messages, notice: "Contact message was successfully updated." }
        format.json { render :show, status: :ok, location: @contact_message }
      else
        format.turbo_stream  do
          render turbo_stream: turbo_stream.update(@contact_message, 
                                partial: "/public/contact_messages/form", 
                                locals: {contact_message: @contact_message})
        end
        format.html           { render :edit, status: :unprocessable_entity }
        format.json           { render json: @contact_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_messages/1 or /contact_messages/1.json
  def destroy
    @contact_message.destroy

    respond_to do |format|
      format.turbo_stream do
          render turbo_stream:  [
            turbo_stream.remove(@contact_message),
            turbo_stream.update('contact_message_counter', 
                                  html: ContactMessage.count.to_s),
            turbo_stream.update('contact_message_notice', 
                                "Contact message #{@contact_message.id} successfully deleted!")
          ]
      end
      format.html { redirect_to contact_messages_url, notice: "Contact message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_message
      @contact_message = @site.contact_messages.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_message_params
      strong_params = params.require(:contact_message).permit(
      :first_name, 
      :last_name, 
      :email, 
      :phone, 
      :subject, 
      :body)

      strong_params

    end
end
