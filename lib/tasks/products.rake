desc "Генерация товаров"
namespace :products do
  task :create => :environment do
  	# TODO переделать с использованием картинок!!!!
    # 45.times do |i|
    #   p = Product.new(title: "Товар #{i+1}",
    #                  price: rand(1.0e6) / 1000 + 1,
    #                  color: )
    #   p.description = "Lorem ipsum #{rand(1000) + 1}..."
    #   p.save!
    # end
  end
end
