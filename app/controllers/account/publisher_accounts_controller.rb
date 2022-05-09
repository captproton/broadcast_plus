class Account::PublisherAccountsController < Account::ApplicationController
  account_load_and_authorize_resource :publisher_account, through: :site, through_association: :publisher_accounts

  # GET /account/sites/:site_id/publisher_accounts
  # GET /account/sites/:site_id/publisher_accounts.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/publisher_accounts/:id
  # GET /account/publisher_accounts/:id.json
  def show
  end

  # GET /account/sites/:site_id/publisher_accounts/new
  def new
  end

  # GET /account/publisher_accounts/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/publisher_accounts
  # POST /account/sites/:site_id/publisher_accounts.json
  def create
    respond_to do |format|
      if @publisher_account.save
        format.html { redirect_to [:account, @site, :publisher_accounts], notice: I18n.t("publisher_accounts.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @publisher_account] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @publisher_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/publisher_accounts/:id
  # PATCH/PUT /account/publisher_accounts/:id.json
  def update
    respond_to do |format|
      if @publisher_account.update(publisher_account_params)
        format.html { redirect_to [:account, @publisher_account], notice: I18n.t("publisher_accounts.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @publisher_account] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @publisher_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/publisher_accounts/:id
  # DELETE /account/publisher_accounts/:id.json
  def destroy
    @publisher_account.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :publisher_accounts], notice: I18n.t("publisher_accounts.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def publisher_account_params
    strong_params = params.require(:publisher_account).permit(
      :name,
      :url,
      :font_awesome_class,
      :network_kind,
      :blurb,
      :svg_logo,
      :svg_logo_style,
      :frontpage_ranking,
      :sidebar_ranking,
      :footer_ranking,
      :podcast_ranking,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
