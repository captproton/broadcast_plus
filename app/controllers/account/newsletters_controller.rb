class Account::NewslettersController < Account::ApplicationController
  account_load_and_authorize_resource :newsletter, through: :site, through_association: :newsletters

  # GET /account/sites/:site_id/newsletters
  # GET /account/sites/:site_id/newsletters.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/newsletters/:id
  # GET /account/newsletters/:id.json
  def show
  end

  # GET /account/sites/:site_id/newsletters/new
  def new
  end

  # GET /account/newsletters/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/newsletters
  # POST /account/sites/:site_id/newsletters.json
  def create
    respond_to do |format|
      if @newsletter.save
        format.html { redirect_to [:account, @site, :newsletters], notice: I18n.t("newsletters.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @newsletter] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/newsletters/:id
  # PATCH/PUT /account/newsletters/:id.json
  def update
    respond_to do |format|
      if @newsletter.update(newsletter_params)
        format.html { redirect_to [:account, @newsletter], notice: I18n.t("newsletters.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @newsletter] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/newsletters/:id
  # DELETE /account/newsletters/:id.json
  def destroy
    @newsletter.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :newsletters], notice: I18n.t("newsletters.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def newsletter_params
    strong_params = params.require(:newsletter).permit(
      :title,
      :mailing_group,
      :sender,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
