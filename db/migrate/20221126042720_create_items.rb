class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :type
      t.text :description
      t.decimal :price
      t.string :size
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
