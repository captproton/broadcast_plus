class Account::LegalTextsController < Account::ApplicationController
  account_load_and_authorize_resource :legal_text, through: :site, through_association: :legal_texts

  # GET /account/sites/:site_id/legal_texts
  # GET /account/sites/:site_id/legal_texts.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/legal_texts/:id
  # GET /account/legal_texts/:id.json
  def show
  end

  # GET /account/sites/:site_id/legal_texts/new
  def new
  end

  # GET /account/legal_texts/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/legal_texts
  # POST /account/sites/:site_id/legal_texts.json
  def create
    respond_to do |format|
      if @legal_text.save
        format.html { redirect_to [:account, @site, :legal_texts], notice: I18n.t("legal_texts.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @legal_text] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @legal_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/legal_texts/:id
  # PATCH/PUT /account/legal_texts/:id.json
  def update
    respond_to do |format|
      if @legal_text.update(legal_text_params)
        format.html { redirect_to [:account, @legal_text], notice: I18n.t("legal_texts.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @legal_text] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @legal_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/legal_texts/:id
  # DELETE /account/legal_texts/:id.json
  def destroy
    @legal_text.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :legal_texts], notice: I18n.t("legal_texts.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def legal_text_params
    strong_params = params.require(:legal_text).permit(
      :title,
      :body,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
