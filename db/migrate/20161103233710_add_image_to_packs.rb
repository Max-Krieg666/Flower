class AddImageToPacks < ActiveRecord::Migration
  def change
    add_attachment :packs, :image
  end
end