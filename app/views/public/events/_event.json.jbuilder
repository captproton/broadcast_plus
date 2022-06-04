json.extract! meetup, :id, :title, :start_date, :end_date, :more_info_url, :location, :created_at, :updated_at
json.url meetup_url(meetup, format: :json)
