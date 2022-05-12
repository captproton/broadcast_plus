class Account::SettingGeneralInfosController < Account::ApplicationController
  account_load_and_authorize_resource :setting_general_info, through: :site, through_association: :setting_general_infos

  # GET /account/sites/:site_id/setting_general_infos
  # GET /account/sites/:site_id/setting_general_infos.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_general_infos/:id
  # GET /account/setting_general_infos/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_general_infos/new
  def new
  end

  # GET /account/setting_general_infos/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_general_infos
  # POST /account/sites/:site_id/setting_general_infos.json
  def create
    respond_to do |format|
      if @setting_general_info.save
        format.html { redirect_to [:account, @site, :setting_general_infos], notice: I18n.t("setting_general_infos.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_general_info] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_general_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_general_infos/:id
  # PATCH/PUT /account/setting_general_infos/:id.json
  def update
    respond_to do |format|
      if @setting_general_info.update(setting_general_info_params)
        format.html { redirect_to [:account, @setting_general_info], notice: I18n.t("setting_general_infos.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_general_info] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_general_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_general_infos/:id
  # DELETE /account/setting_general_infos/:id.json
  def destroy
    @setting_general_info.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_general_infos], notice: I18n.t("setting_general_infos.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_general_info_params
    strong_params = params.require(:setting_general_info).permit(
      :site_name,
      :plain_text_name,
      :text_number,
      :newsletter_subscription_url,
      :default_meta_blurb,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
