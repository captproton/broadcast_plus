class Account::SettingPressKitsController < Account::ApplicationController
  account_load_and_authorize_resource :setting_press_kit, through: :site, through_association: :setting_press_kits

  # GET /account/sites/:site_id/setting_press_kits
  # GET /account/sites/:site_id/setting_press_kits.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_press_kits/:id
  # GET /account/setting_press_kits/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_press_kits/new
  def new
  end

  # GET /account/setting_press_kits/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_press_kits
  # POST /account/sites/:site_id/setting_press_kits.json
  def create
    respond_to do |format|
      if @setting_press_kit.save
        format.html { redirect_to [:account, @site, :setting_press_kits], notice: I18n.t("setting_press_kits.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_press_kit] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_press_kit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_press_kits/:id
  # PATCH/PUT /account/setting_press_kits/:id.json
  def update
    respond_to do |format|
      if @setting_press_kit.update(setting_press_kit_params)
        format.html { redirect_to [:account, @setting_press_kit], notice: I18n.t("setting_press_kits.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_press_kit] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_press_kit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_press_kits/:id
  # DELETE /account/setting_press_kits/:id.json
  def destroy
    @setting_press_kit.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_press_kits], notice: I18n.t("setting_press_kits.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_press_kit_params
    strong_params = params.require(:setting_press_kit).permit(
      :hero_title,
      :hero_image,
      :name,
      :birthplace,
      :biography,
      :birthdate,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    assign_date(strong_params, :birthdate)
    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
