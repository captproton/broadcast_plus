class Account::SettingMediaAppearancesPagesController < Account::ApplicationController
  account_load_and_authorize_resource :setting_media_appearances_page, through: :site, through_association: :setting_media_appearances_pages

  # GET /account/sites/:site_id/setting_media_appearances_pages
  # GET /account/sites/:site_id/setting_media_appearances_pages.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_media_appearances_pages/:id
  # GET /account/setting_media_appearances_pages/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_media_appearances_pages/new
  def new
  end

  # GET /account/setting_media_appearances_pages/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_media_appearances_pages
  # POST /account/sites/:site_id/setting_media_appearances_pages.json
  def create
    respond_to do |format|
      if @setting_media_appearances_page.save
        format.html { redirect_to [:account, @site, :setting_media_appearances_pages], notice: I18n.t("setting_media_appearances_pages.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_media_appearances_page] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_media_appearances_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_media_appearances_pages/:id
  # PATCH/PUT /account/setting_media_appearances_pages/:id.json
  def update
    respond_to do |format|
      if @setting_media_appearances_page.update(setting_media_appearances_page_params)
        format.html { redirect_to [:account, @setting_media_appearances_page], notice: I18n.t("setting_media_appearances_pages.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_media_appearances_page] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_media_appearances_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_media_appearances_pages/:id
  # DELETE /account/setting_media_appearances_pages/:id.json
  def destroy
    @setting_media_appearances_page.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_media_appearances_pages], notice: I18n.t("setting_media_appearances_pages.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_media_appearances_page_params
    strong_params = params.require(:setting_media_appearances_page).permit(
      :hero_title,
      :hero_image,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
