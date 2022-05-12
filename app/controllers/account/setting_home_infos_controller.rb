class Account::SettingHomeInfosController < Account::ApplicationController
  account_load_and_authorize_resource :setting_home_info, through: :site, through_association: :setting_home_infos

  # GET /account/sites/:site_id/setting_home_infos
  # GET /account/sites/:site_id/setting_home_infos.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_home_infos/:id
  # GET /account/setting_home_infos/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_home_infos/new
  def new
  end

  # GET /account/setting_home_infos/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_home_infos
  # POST /account/sites/:site_id/setting_home_infos.json
  def create
    respond_to do |format|
      if @setting_home_info.save
        format.html { redirect_to [:account, @site, :setting_home_infos], notice: I18n.t("setting_home_infos.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_home_info] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_home_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_home_infos/:id
  # PATCH/PUT /account/setting_home_infos/:id.json
  def update
    respond_to do |format|
      if @setting_home_info.update(setting_home_info_params)
        format.html { redirect_to [:account, @setting_home_info], notice: I18n.t("setting_home_infos.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_home_info] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_home_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_home_infos/:id
  # DELETE /account/setting_home_infos/:id.json
  def destroy
    @setting_home_info.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_home_infos], notice: I18n.t("setting_home_infos.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_home_info_params
    strong_params = params.require(:setting_home_info).permit(
      :biography_blurb,
      :video_billboard_url,
      :watch_this_video_url,
      :bio_link_label,
      :watch_this_poster_url,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
