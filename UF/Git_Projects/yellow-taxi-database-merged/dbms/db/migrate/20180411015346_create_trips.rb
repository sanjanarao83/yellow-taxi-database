class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :recordid
      t.integer :vendorid
      t.datetime :pickup_datetime
      t.datetime :dropoff_datetime
      t.integer :passenger_count
      t.float :trip_distance
      t.string :store_and_fwd_flag

      t.timestamps
    end
  end
end
