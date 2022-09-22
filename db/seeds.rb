# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.create(first_name: "Jane", last_name: "Powell", email: "jpowell@email.com", address: "123 sonnybrook lane")
Customer.create(first_name: "Judy", last_name: "Garland", email: "jgarland@email.com", address: "123 hollywood lane")

Tea.create(title: "Green Tea", description: "refreshing green tea", temperature: 80, brew_time: 3)
Tea.create(title: "Lavender Tea", description: "Soothing tea", temperature: 80, brew_time: 3)
Tea.create(title: "Ginger Tea", description: "Good for colds", temperature: 70, brew_time: 4)