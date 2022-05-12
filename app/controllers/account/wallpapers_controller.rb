class Account::WallpapersController < Account::ApplicationController
  account_load_and_authorize_resource :wallpaper, through: :site, through_association: :wallpapers

  # GET /account/sites/:site_id/wallpapers
  # GET /account/sites/:site_id/wallpapers.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/wallpapers/:id
  # GET /account/wallpapers/:id.json
  def show
  end

  # GET /account/sites/:site_id/wallpapers/new
  def new
  end

  # GET /account/wallpapers/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/wallpapers
  # POST /account/sites/:site_id/wallpapers.json
  def create
    respond_to do |format|
      if @wallpaper.save
        format.html { redirect_to [:account, @site, :wallpapers], notice: I18n.t("wallpapers.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @wallpaper] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/wallpapers/:id
  # PATCH/PUT /account/wallpapers/:id.json
  def update
    respond_to do |format|
      if @wallpaper.update(wallpaper_params)
        format.html { redirect_to [:account, @wallpaper], notice: I18n.t("wallpapers.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @wallpaper] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/wallpapers/:id
  # DELETE /account/wallpapers/:id.json
  def destroy
    @wallpaper.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :wallpapers], notice: I18n.t("wallpapers.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def wallpaper_params
    strong_params = params.require(:wallpaper).permit(
      :name,
      :image,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
