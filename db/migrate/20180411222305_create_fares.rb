class CreateFares < ActiveRecord::Migration[5.1]
  def change
    create_table :fares do |t|
      t.integer :recordid
      t.float :tip_amount
      t.float :extra
      t.float :mta_tax
      t.integer :ratecodeid
      t.float :tolls_amount
      t.float :total_amount
      t.float :fare_amount
      t.float :improvement_surcharge
      t.integer :payment_type

      t.timestamps
    end
  end
end
