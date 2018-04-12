json.extract! fare, :id, :recordid, :tip_amount, :extra, :mta_tax, :ratecodeid, :tolls_amount, :total_amount, :fare_amount, :improvement_surcharge, :payment_type, :created_at, :updated_at
json.url fare_url(fare, format: :json)
