class CreateKinds < ActiveRecord::Migration
  def change
    create_table :kinds do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
