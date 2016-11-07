class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items, -> { includes(:product).order(:created_at) }, dependent: :destroy
  scope :ordering, -> { order(created_at: :desc) }

  STATUSES = %w(Инициализация Оформлен Подтверждён Отменён Доставляется Завершён).freeze # 0 1 2 3 4 5
  validates_presence_of :address, if: :try_confirm
  validates :status, presence: true, inclusion: { in: 0...STATUSES.size }

  def add_item(p)
    line_item = line_items.where(product_id: p.id).first
    unless line_item
      line_item = self.line_items.build(product: p, quantity: 0, price: p.price)
    end
    line_item.quantity += 1
    line_item.save
  end

  def total_line_items
    line_items.sum(:quantity)
  end

  def total_amount
    line_items.sum("quantity*line_items.price")
  end

  def status_view
    STATUSES[status]
  end

  def try_confirm
    line_items.size > 0 && status == 0
  end
end