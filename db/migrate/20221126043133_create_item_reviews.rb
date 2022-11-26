class CreateItemReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :item_reviews do |t|
      t.integer :rating
      t.string :feedback
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
