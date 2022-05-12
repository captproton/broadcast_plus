class Account::SettingBiographiesController < Account::ApplicationController
  account_load_and_authorize_resource :setting_biography, through: :site, through_association: :setting_biographies

  # GET /account/sites/:site_id/setting_biographies
  # GET /account/sites/:site_id/setting_biographies.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_biographies/:id
  # GET /account/setting_biographies/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_biographies/new
  def new
  end

  # GET /account/setting_biographies/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_biographies
  # POST /account/sites/:site_id/setting_biographies.json
  def create
    respond_to do |format|
      if @setting_biography.save
        format.html { redirect_to [:account, @site, :setting_biographies], notice: I18n.t("setting_biographies.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_biography] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_biography.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_biographies/:id
  # PATCH/PUT /account/setting_biographies/:id.json
  def update
    respond_to do |format|
      if @setting_biography.update(setting_biography_params)
        format.html { redirect_to [:account, @setting_biography], notice: I18n.t("setting_biographies.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_biography] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_biography.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_biographies/:id
  # DELETE /account/setting_biographies/:id.json
  def destroy
    @setting_biography.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_biographies], notice: I18n.t("setting_biographies.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_biography_params
    strong_params = params.require(:setting_biography).permit(
      :title,
      :hero_image,
      :body,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
