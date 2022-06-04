class Account::PressKitLinksController < Account::ApplicationController
  account_load_and_authorize_resource :press_kit_link, through: :setting_press_kit, through_association: :press_kit_links

  # GET /account/setting_press_kits/:setting_press_kit_id/press_kit_links
  # GET /account/setting_press_kits/:setting_press_kit_id/press_kit_links.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @setting_press_kit]
  end

  # GET /account/press_kit_links/:id
  # GET /account/press_kit_links/:id.json
  def show
  end

  # GET /account/setting_press_kits/:setting_press_kit_id/press_kit_links/new
  def new
  end

  # GET /account/press_kit_links/:id/edit
  def edit
  end

  # POST /account/setting_press_kits/:setting_press_kit_id/press_kit_links
  # POST /account/setting_press_kits/:setting_press_kit_id/press_kit_links.json
  def create
    respond_to do |format|
      if @press_kit_link.save
        format.html { redirect_to [:account, @setting_press_kit, :press_kit_links], notice: I18n.t("press_kit_links.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @press_kit_link] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @press_kit_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/press_kit_links/:id
  # PATCH/PUT /account/press_kit_links/:id.json
  def update
    respond_to do |format|
      if @press_kit_link.update(press_kit_link_params)
        format.html { redirect_to [:account, @press_kit_link], notice: I18n.t("press_kit_links.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @press_kit_link] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @press_kit_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/press_kit_links/:id
  # DELETE /account/press_kit_links/:id.json
  def destroy
    @press_kit_link.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @setting_press_kit, :press_kit_links], notice: I18n.t("press_kit_links.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def press_kit_link_params
    strong_params = params.require(:press_kit_link).permit(
      :label,
      :url,
      :category,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
