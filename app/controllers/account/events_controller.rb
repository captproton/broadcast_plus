class Account::EventsController < Account::ApplicationController
  account_load_and_authorize_resource :event, through: :site, through_association: :events

  # GET /account/sites/:site_id/events
  # GET /account/sites/:site_id/events.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/events/:id
  # GET /account/events/:id.json
  def show
  end

  # GET /account/sites/:site_id/events/new
  def new
  end

  # GET /account/events/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/events
  # POST /account/sites/:site_id/events.json
  def create
    respond_to do |format|
      if @event.save
        format.html { redirect_to [:account, @site, :events], notice: I18n.t("events.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @event] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/events/:id
  # PATCH/PUT /account/events/:id.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to [:account, @event], notice: I18n.t("events.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @event] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/events/:id
  # DELETE /account/events/:id.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :events], notice: I18n.t("events.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    strong_params = params.require(:event).permit(
      :title,
      :start_date,
      :finish_date,
      :more_info_url,
      :location,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    assign_date(strong_params, :start_date)
    assign_date(strong_params, :finish_date)
    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
