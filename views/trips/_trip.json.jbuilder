json.extract! trip, :id, :recordid, :vendorid, :pickup_datetime, :dropoff_datetime, :passenger_count, :trip_distance, :store_and_fwd_flag, :created_at, :updated_at
json.url trip_url(trip, format: :json)
