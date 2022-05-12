class Account::SettingPodcastsController < Account::ApplicationController
  account_load_and_authorize_resource :setting_podcast, through: :site, through_association: :setting_podcasts

  # GET /account/sites/:site_id/setting_podcasts
  # GET /account/sites/:site_id/setting_podcasts.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_podcasts/:id
  # GET /account/setting_podcasts/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_podcasts/new
  def new
  end

  # GET /account/setting_podcasts/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_podcasts
  # POST /account/sites/:site_id/setting_podcasts.json
  def create
    respond_to do |format|
      if @setting_podcast.save
        format.html { redirect_to [:account, @site, :setting_podcasts], notice: I18n.t("setting_podcasts.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_podcast] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_podcasts/:id
  # PATCH/PUT /account/setting_podcasts/:id.json
  def update
    respond_to do |format|
      if @setting_podcast.update(setting_podcast_params)
        format.html { redirect_to [:account, @setting_podcast], notice: I18n.t("setting_podcasts.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_podcast] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_podcasts/:id
  # DELETE /account/setting_podcasts/:id.json
  def destroy
    @setting_podcast.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_podcasts], notice: I18n.t("setting_podcasts.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_podcast_params
    strong_params = params.require(:setting_podcast).permit(
      :hero_title,
      :hero_image,
      :title,
      :body,
      :podcast_player_src,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
