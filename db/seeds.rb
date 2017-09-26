# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
super_admin = UserLevel.create!(description: 'super admin', level: 0)
UserLevel.create!(description: 'admin', level: 1)
UserLevel.create!(description: 'web master', level: 2)
UserLevel.create!(description: 'moderator', level: 3)
UserLevel.create!(description: 'member', level: 4)
UserLevel.create!(description: 'guest', level: 5)
password = 'password'
super_user = User.create!(email: 'admin@example.com',
               password: password,
               password_confirmation: password,
               active: true,
               user_level: super_admin)
Forum.create!(name: 'Main Forum', description: 'Company Forum', admin: super_user)
