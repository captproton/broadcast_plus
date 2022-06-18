class Api::V1::ContactMessagesEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Contact Message ID"
    end

    params :contact_message do
      optional :email, type: String, desc: Api.heading(:email)
      optional :first_name, type: String, desc: Api.heading(:first_name)
      optional :last_name, type: String, desc: Api.heading(:last_name)
      optional :phone, type: String, desc: Api.heading(:phone)
      optional :subject, type: String, desc: Api.heading(:subject)
      optional :body, type: String, desc: Api.heading(:body)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource ContactMessage
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
    get "/:site_id/contact_messages" do
      @paginated_contact_messages = paginate @contact_messages
      render @paginated_contact_messages, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :contact_message
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/contact_messages" do
      if @contact_message.save
        render @contact_message, serializer: Api.serializer
      else
        record_not_saved @contact_message
      end
    end
  end

  resource "contact_messages", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource ContactMessage
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
        render @contact_message, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :contact_message
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @contact_message.update(declared(params, include_missing: false))
          render @contact_message, serializer: Api.serializer
        else
          record_not_saved @contact_message
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
        render @contact_message.destroy, serializer: Api.serializer
      end
    end
  end
end
