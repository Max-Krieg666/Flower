class Product < ActiveRecord::Base
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }
  has_many :line_items, dependent: :nullify
  belongs_to :kind
  before_destroy :can_destroy?
  COLORS = %w(Белый Серый Чёрный
             Красный Розовый Сиреневый
             Пурпурный Синий Голубой Жёлтый
             Зелёный Оранжевый Оттенок Другой Разный Разноцветный).freeze # всего 16

  validates :image,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 1.megabytes },
            attachment_file_name: { :matches => [/png\Z/, /jpe?g\Z/] }
  validates :title, presence: true, length: { maximum: 200 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  def can_destroy?
    line_items.blank?
  end

  def color_name
    COLORS[color]
  end

  def set_color
    case color
    when 0 # Белый
      '#FFF'
    when 1 # Серый
      '#A9A9A9'
    when 3 # Красный
      '#F00'
    when 4 # Розовый
      '#FF1493'
    when 5 # Сиреневый
      '#9400D3'
    when 6 # Пурпурный
      '#800080'
    when 7 # Синий
      '#00F'
    when 8 # Голубой
      '#87CEFA'
    when 9 # Жёлтый
      '#FF0'
    when 10 # Зелёный
      '#0F0'
    when 11 # Оранжевый
      '#FFA500'
    else # Не определён или Чёрный
      '#000'
    end
  end
end
