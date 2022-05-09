class Account::BiographiesController < Account::ApplicationController
  account_load_and_authorize_resource :biography, through: :site, through_association: :biographies

  # GET /account/sites/:site_id/biographies
  # GET /account/sites/:site_id/biographies.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/biographies/:id
  # GET /account/biographies/:id.json
  def show
  end

  # GET /account/sites/:site_id/biographies/new
  def new
  end

  # GET /account/biographies/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/biographies
  # POST /account/sites/:site_id/biographies.json
  def create
    respond_to do |format|
      if @biography.save
        format.html { redirect_to [:account, @site, :biographies], notice: I18n.t("biographies.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @biography] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @biography.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/biographies/:id
  # PATCH/PUT /account/biographies/:id.json
  def update
    respond_to do |format|
      if @biography.update(biography_params)
        format.html { redirect_to [:account, @biography], notice: I18n.t("biographies.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @biography] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @biography.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/biographies/:id
  # DELETE /account/biographies/:id.json
  def destroy
    @biography.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :biographies], notice: I18n.t("biographies.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def biography_params
    strong_params = params.require(:biography).permit(
      :title,
      :header_photo_url,
      :body,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
