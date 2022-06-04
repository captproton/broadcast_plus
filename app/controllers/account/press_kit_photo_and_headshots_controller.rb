class Account::PressKitPhotoAndHeadshotsController < Account::ApplicationController
  account_load_and_authorize_resource :press_kit_photo_and_headshot, through: :setting_press_kit, through_association: :press_kit_photo_and_headshots

  # GET /account/setting_press_kits/:setting_press_kit_id/press_kit_photo_and_headshots
  # GET /account/setting_press_kits/:setting_press_kit_id/press_kit_photo_and_headshots.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @setting_press_kit]
  end

  # GET /account/press_kit_photo_and_headshots/:id
  # GET /account/press_kit_photo_and_headshots/:id.json
  def show
  end

  # GET /account/setting_press_kits/:setting_press_kit_id/press_kit_photo_and_headshots/new
  def new
  end

  # GET /account/press_kit_photo_and_headshots/:id/edit
  def edit
  end

  # POST /account/setting_press_kits/:setting_press_kit_id/press_kit_photo_and_headshots
  # POST /account/setting_press_kits/:setting_press_kit_id/press_kit_photo_and_headshots.json
  def create
    respond_to do |format|
      if @press_kit_photo_and_headshot.save
        format.html { redirect_to [:account, @setting_press_kit, :press_kit_photo_and_headshots], notice: I18n.t("press_kit_photo_and_headshots.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @press_kit_photo_and_headshot] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @press_kit_photo_and_headshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/press_kit_photo_and_headshots/:id
  # PATCH/PUT /account/press_kit_photo_and_headshots/:id.json
  def update
    respond_to do |format|
      if @press_kit_photo_and_headshot.update(press_kit_photo_and_headshot_params)
        format.html { redirect_to [:account, @press_kit_photo_and_headshot], notice: I18n.t("press_kit_photo_and_headshots.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @press_kit_photo_and_headshot] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @press_kit_photo_and_headshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/press_kit_photo_and_headshots/:id
  # DELETE /account/press_kit_photo_and_headshots/:id.json
  def destroy
    @press_kit_photo_and_headshot.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @setting_press_kit, :press_kit_photo_and_headshots], notice: I18n.t("press_kit_photo_and_headshots.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def press_kit_photo_and_headshot_params
    strong_params = params.require(:press_kit_photo_and_headshot).permit(
      :title,
      :description,
      :dimensions_wxh,
      :headshot_or_other,
      :publish_at,
      :photo,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    assign_date(strong_params, :publish_at)
    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
