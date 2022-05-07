class Account::SitesController < Account::ApplicationController
  account_load_and_authorize_resource :site, through: :team, through_association: :sites

  # GET /account/teams/:team_id/sites
  # GET /account/teams/:team_id/sites.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @team]
  end

  # GET /account/sites/:id
  # GET /account/sites/:id.json
  def show
  end

  # GET /account/teams/:team_id/sites/new
  def new
  end

  # GET /account/sites/:id/edit
  def edit
  end

  # POST /account/teams/:team_id/sites
  # POST /account/teams/:team_id/sites.json
  def create
    respond_to do |format|
      if @site.save
        format.html { redirect_to [:account, @team, :sites], notice: I18n.t("sites.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @site] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/sites/:id
  # PATCH/PUT /account/sites/:id.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to [:account, @site], notice: I18n.t("sites.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @site] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/sites/:id
  # DELETE /account/sites/:id.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @team, :sites], notice: I18n.t("sites.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def site_params
    strong_params = params.require(:site).permit(
      :name,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
