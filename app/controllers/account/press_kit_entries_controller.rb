class Account::PressKitEntriesController < Account::ApplicationController
  account_load_and_authorize_resource :press_kit_entry, through: :setting_press_kit, through_association: :press_kit_entries

  # GET /account/setting_press_kits/:setting_press_kit_id/press_kit_entries
  # GET /account/setting_press_kits/:setting_press_kit_id/press_kit_entries.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @setting_press_kit]
  end

  # GET /account/press_kit_entries/:id
  # GET /account/press_kit_entries/:id.json
  def show
  end

  # GET /account/setting_press_kits/:setting_press_kit_id/press_kit_entries/new
  def new
  end

  # GET /account/press_kit_entries/:id/edit
  def edit
  end

  # POST /account/setting_press_kits/:setting_press_kit_id/press_kit_entries
  # POST /account/setting_press_kits/:setting_press_kit_id/press_kit_entries.json
  def create
    respond_to do |format|
      if @press_kit_entry.save
        format.html { redirect_to [:account, @setting_press_kit, :press_kit_entries], notice: I18n.t("press_kit_entries.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @press_kit_entry] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @press_kit_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/press_kit_entries/:id
  # PATCH/PUT /account/press_kit_entries/:id.json
  def update
    respond_to do |format|
      if @press_kit_entry.update(press_kit_entry_params)
        format.html { redirect_to [:account, @press_kit_entry], notice: I18n.t("press_kit_entries.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @press_kit_entry] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @press_kit_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/press_kit_entries/:id
  # DELETE /account/press_kit_entries/:id.json
  def destroy
    @press_kit_entry.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @setting_press_kit, :press_kit_entries], notice: I18n.t("press_kit_entries.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def press_kit_entry_params
    strong_params = params.require(:press_kit_entry).permit(
      :title,
      :article_link,
      :publish_on,
      :release_at,
      :article_image,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    assign_date(strong_params, :publish_on)
    assign_date_and_time(strong_params, :release_at)
    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
