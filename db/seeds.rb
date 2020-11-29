# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'thomas@craft.com', password: 'password', password_confirmation: 'password')


Product.create(name: 'Hamburger', description: 'Yummy burger...', price: 50.0)
Product.create(name: 'Steak dinner', description: 'Yummy steak...', price: 150.0)
Product.create(name: 'Soup of the day', description: 'Creamy soup...', price: 25.0)