class Api::V1::EventsEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Event ID"
    end

    params :event do
      optional :title, type: String, desc: Api.heading(:title)
      optional :start_date, type: String, desc: Api.heading(:start_date)
      optional :more_info_url, type: String, desc: Api.heading(:more_info_url)
      optional :location, type: String, desc: Api.heading(:location)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource Event
    end

    #
    # INDEX
    #

    desc Api.title(:index), &Api.index_desc
    params do
      use :site_id
    end
    oauth2
    paginate per_page: 100
    get "/:site_id/events" do
      @paginated_events = paginate @events
      render @paginated_events, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :event
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/events" do
      if @event.save
        render @event, serializer: Api.serializer
      else
        record_not_saved @event
      end
    end
  end

  resource "events", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource Event
    end

    #
    # SHOW
    #

    desc Api.title(:show), &Api.show_desc
    params do
      use :id
    end
    oauth2
    route_param :id do
      get do
        render @event, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :event
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @event.update(declared(params, include_missing: false))
          render @event, serializer: Api.serializer
        else
          record_not_saved @event
        end
      end
    end

    #
    # DESTROY
    #

    desc Api.title(:destroy), &Api.destroy_desc
    params do
      use :id
    end
    route_setting :api_resource_options, permission: :destroy
    oauth2 "delete"
    route_param :id do
      delete do
        render @event.destroy, serializer: Api.serializer
      end
    end
  end
end
