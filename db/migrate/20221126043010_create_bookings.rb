class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :status
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :booking_price
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
