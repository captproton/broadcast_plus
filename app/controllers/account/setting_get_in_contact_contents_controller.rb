class Account::SettingGetInContactContentsController < Account::ApplicationController
  account_load_and_authorize_resource :setting_get_in_contact_content, through: :site, through_association: :setting_get_in_contact_contents

  # GET /account/sites/:site_id/setting_get_in_contact_contents
  # GET /account/sites/:site_id/setting_get_in_contact_contents.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/setting_get_in_contact_contents/:id
  # GET /account/setting_get_in_contact_contents/:id.json
  def show
  end

  # GET /account/sites/:site_id/setting_get_in_contact_contents/new
  def new
  end

  # GET /account/setting_get_in_contact_contents/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/setting_get_in_contact_contents
  # POST /account/sites/:site_id/setting_get_in_contact_contents.json
  def create
    respond_to do |format|
      if @setting_get_in_contact_content.save
        format.html { redirect_to [:account, @site, :setting_get_in_contact_contents], notice: I18n.t("setting_get_in_contact_contents.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @setting_get_in_contact_content] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setting_get_in_contact_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/setting_get_in_contact_contents/:id
  # PATCH/PUT /account/setting_get_in_contact_contents/:id.json
  def update
    respond_to do |format|
      if @setting_get_in_contact_content.update(setting_get_in_contact_content_params)
        format.html { redirect_to [:account, @setting_get_in_contact_content], notice: I18n.t("setting_get_in_contact_contents.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @setting_get_in_contact_content] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting_get_in_contact_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/setting_get_in_contact_contents/:id
  # DELETE /account/setting_get_in_contact_contents/:id.json
  def destroy
    @setting_get_in_contact_content.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :setting_get_in_contact_contents], notice: I18n.t("setting_get_in_contact_contents.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_get_in_contact_content_params
    strong_params = params.require(:setting_get_in_contact_content).permit(
      :first_name,
      :last_name,
      :youtube_url,
      :youtube_image_url,
      :page_message,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
