desc 'Создание 3 пользователей с разными правами'
namespace :users do
  task :create => :environment do
    us1 = User.create(email: 'admin@admin.ru',
                      password: 'adminadmin',
                      phone_number: '1234567890',
                      address: 'Moscow', role: 2,
                      fio: 'Администратор магазина')
    us2 = User.create(email: 'moderator@moderator.ru',
                      password: 'moderator',
                      phone_number: '8888777665',
                      address: 'Ladoga', role: 1,
                      fio: 'Модератор магазина')
    us3 = User.create(email: 'user@user.ru',
                      password: 'useruser',
                      phone_number: '0987656789',
                      address: 'Yakutsk', role: 0,
                      fio: 'Тестовый Пользователь')
  end
end
