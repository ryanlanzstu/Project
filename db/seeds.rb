# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

list = List.create(name: 'ToDo')
list.tasks.create(name: 'Figure out calendar')
list.tasks.create(name: 'Add to project')
list.tasks.create(name: 'Stylize')
list = List.create(name: 'Doing Now')

list = List.create(name: 'Finished')
