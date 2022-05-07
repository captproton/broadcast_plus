class Account::MediaAppearancesController < Account::ApplicationController
  account_load_and_authorize_resource :media_appearance, through: :site, through_association: :media_appearances

  # GET /account/sites/:site_id/media_appearances
  # GET /account/sites/:site_id/media_appearances.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/media_appearances/:id
  # GET /account/media_appearances/:id.json
  def show
  end

  # GET /account/sites/:site_id/media_appearances/new
  def new
  end

  # GET /account/media_appearances/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/media_appearances
  # POST /account/sites/:site_id/media_appearances.json
  def create
    respond_to do |format|
      if @media_appearance.save
        format.html { redirect_to [:account, @site, :media_appearances], notice: I18n.t("media_appearances.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @media_appearance] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @media_appearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/media_appearances/:id
  # PATCH/PUT /account/media_appearances/:id.json
  def update
    respond_to do |format|
      if @media_appearance.update(media_appearance_params)
        format.html { redirect_to [:account, @media_appearance], notice: I18n.t("media_appearances.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @media_appearance] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @media_appearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/media_appearances/:id
  # DELETE /account/media_appearances/:id.json
  def destroy
    @media_appearance.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :media_appearances], notice: I18n.t("media_appearances.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def media_appearance_params
    strong_params = params.require(:media_appearance).permit(
      :title,
      :published_on,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    assign_date(strong_params, :published_on)
    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
