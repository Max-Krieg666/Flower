class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  belongs_to :pack

  validates :product, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true

  def total_price
    quantity * price
  end
end
