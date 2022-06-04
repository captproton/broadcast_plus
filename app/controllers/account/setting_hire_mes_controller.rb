class Account::SettingHireMesController < Account::ApplicationController
  account_load_and_authorize_resource :setting_hire_me, through: :site, through_association: :setting_hire_mes

  # GET /account/sites/:site_id/setting_hire_mes
  # GET /account/sites/:site_id/setting_hire_mes.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_hire_mes/:id
  # GET /account/setting_hire_mes/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_hire_mes/new
  def new
  end

  # GET /account/setting_hire_mes/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_hire_mes
  # POST /account/sites/:site_id/setting_hire_mes.json
  def create
    respond_to do |format|
      if @setting_hire_me.save
        format.html { redirect_to [:account, @site, :setting_hire_mes], notice: I18n.t("setting_hire_mes.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_hire_me] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_hire_me.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_hire_mes/:id
  # PATCH/PUT /account/setting_hire_mes/:id.json
  def update
    respond_to do |format|
      if @setting_hire_me.update(setting_hire_me_params)
        format.html { redirect_to [:account, @setting_hire_me], notice: I18n.t("setting_hire_mes.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_hire_me] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_hire_me.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_hire_mes/:id
  # DELETE /account/setting_hire_mes/:id.json
  def destroy
    @setting_hire_me.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_hire_mes], notice: I18n.t("setting_hire_mes.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_hire_me_params
    strong_params = params.require(:setting_hire_me).permit(
      :title,
      :learn_more_text,
      :body,
      :learn_more_pdf,
      :hero_image,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
