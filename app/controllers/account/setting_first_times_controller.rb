class Account::SettingFirstTimesController < Account::ApplicationController
  account_load_and_authorize_resource :setting_first_time, through: :site, through_association: :setting_first_times

  # GET /account/sites/:site_id/setting_first_times
  # GET /account/sites/:site_id/setting_first_times.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_first_times/:id
  # GET /account/setting_first_times/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_first_times/new
  def new
  end

  # GET /account/setting_first_times/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_first_times
  # POST /account/sites/:site_id/setting_first_times.json
  def create
    respond_to do |format|
      if @setting_first_time.save
        format.html { redirect_to [:account, @site, :setting_first_times], notice: I18n.t("setting_first_times.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_first_time] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_first_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_first_times/:id
  # PATCH/PUT /account/setting_first_times/:id.json
  def update
    respond_to do |format|
      if @setting_first_time.update(setting_first_time_params)
        format.html { redirect_to [:account, @setting_first_time], notice: I18n.t("setting_first_times.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_first_time] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_first_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_first_times/:id
  # DELETE /account/setting_first_times/:id.json
  def destroy
    @setting_first_time.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_first_times], notice: I18n.t("setting_first_times.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_first_time_params
    strong_params = params.require(:setting_first_time).permit(
      :hero_title,
      :hero_image,
      :first_name,
      :last_name,
      :biography,
      :featured_aside_image,
      :blurb,
      :twitter_handle,
      :featured_youtube_video_url,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
