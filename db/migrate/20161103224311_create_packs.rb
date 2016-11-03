class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :title
      t.decimal :price, precision: 15, scale: 2
      t.integer :color
      t.text :description

      t.timestamps null: false
    end
  end
end
