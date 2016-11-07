class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, null: true
      t.text :address
      t.string :fio
      t.string :phone
      t.integer :status, default: 0
      t.text :comment

      t.timestamps null: false
    end
  end
end
