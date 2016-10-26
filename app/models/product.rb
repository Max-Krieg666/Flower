class Product < ActiveRecord::Base
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }
  has_many :line_items, dependent: :nullify
  belongs_to :kind
  before_destroy :can_destroy?
  COLORS = %(Белый Серый Чёрный
             Красный Розовый Сиреневый
             Пурпурный Синий Голубой Жёлтый
             Зелёный Оранжевый Оттенок Другой Разный).freeze # всего 15

  validates :image,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 1.megabytes },
            attachment_file_name: { :matches => [/png\Z/, /jpe?g\Z/] }
  validates :title, presence: true, length: { maximum: 200 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :weight, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

  def can_destroy?
    line_items.blank?
  end

  def color_name
    COLORS[color]
  end
end
