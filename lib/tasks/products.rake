desc 'Генерация товаров'
namespace :products do
  task create: :environment do
  	Product.create(title: 'Тюльпан красный',
                   price: 53.0,
                   color: 3,
                   description: 'Красный тюльпан подарит наповторимую радость Вам и Вашим близким.',
                   image: File.new(Rails.root + 'app/assets/images/tulpan_red.jpg')
                   kind_id: 2)
    Product.create(title: 'Тюльпан жёлтый',
                   price: 55.5,
                   color: 9,
                   image: File.new(Rails.root + 'app/assets/images/tulpan_yellow.jpg')
                   kind_id: 2)
    Product.create(title: 'Тюльпан белый',
                   price: 53.0,
                   color: 0,
                   image: File.new(Rails.root + 'app/assets/images/tulpan_white.jpg')
                   kind_id: 2)
    Pack.create(title: 'Плёнка <<Разноцветная>>',
                color: 15,
                price: 25.0,
                image: File.new(Rails.root + 'app/assets/images/gift_pack.jpg'),
                description: 'Яркая и интересная плёнка разных цветов идеально подойдёт практически к любому букету!')
    Pack.create(title: 'Без обёртки',
                color: 15,
                price: 0.0,
                image: File.new(Rails.root + 'app/assets/images/no_image.jpg'))
  end
end
