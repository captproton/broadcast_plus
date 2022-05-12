class Account::SettingEventPagesController < Account::ApplicationController
  account_load_and_authorize_resource :setting_event_page, through: :site, through_association: :setting_event_pages

  # GET /account/sites/:site_id/setting_event_pages
  # GET /account/sites/:site_id/setting_event_pages.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_event_pages/:id
  # GET /account/setting_event_pages/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_event_pages/new
  def new
  end

  # GET /account/setting_event_pages/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_event_pages
  # POST /account/sites/:site_id/setting_event_pages.json
  def create
    respond_to do |format|
      if @setting_event_page.save
        format.html { redirect_to [:account, @site, :setting_event_pages], notice: I18n.t("setting_event_pages.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_event_page] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_event_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_event_pages/:id
  # PATCH/PUT /account/setting_event_pages/:id.json
  def update
    respond_to do |format|
      if @setting_event_page.update(setting_event_page_params)
        format.html { redirect_to [:account, @setting_event_page], notice: I18n.t("setting_event_pages.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_event_page] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_event_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_event_pages/:id
  # DELETE /account/setting_event_pages/:id.json
  def destroy
    @setting_event_page.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_event_pages], notice: I18n.t("setting_event_pages.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_event_page_params
    strong_params = params.require(:setting_event_page).permit(
      :hero_title,
      :hero_image,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
