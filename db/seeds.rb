# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Category.delete_all
Task.delete_all

user = User.create(
  email: 'janedoe@mail.com',
  password: 'janedoe'
)

user2 = User.create(
  email: 'johnhamilton@mail.com',
  password: 'johnhamilton'
)

category = Category.create(
  title: 'Sample Category Title',
  details: 'Sample Category Details',
  user_id: user.id
)

category2 = Category.create(
  title: 'Sample Category Title 2',
  details: 'Sample Category Details 2',
  user_id: user.id
)

category3 = Category.create(
  title: 'Sample Category Title 3',
  details: 'Sample Category Details 3',
  user_id: user2.id
)

Task.create(
  details: 'Sample Today Task',
  priority: Date.current,
  done: false,
  user_id: user.id,
  category_id: category.id
)

Task.create(
  details: 'Sample Today Task 2',
  priority: Date.current,
  done: true,
  user_id: user.id,
  category_id: category.id
)

Task.create(
  details: 'Sample Future Task',
  priority: Date.current.tomorrow,
  done: false,
  user_id: user.id,
  category_id: category2.id
)

Task.create(
  details: 'Sample Task Done',
  priority: Date.current,
  done: true,
  user_id: user2.id,
  category_id: category3.id
)

task = Task.new(
  details: 'Sample Past Task',
  priority: Date.current.yesterday,
  done: false,
  user_id: user2.id,
  category_id: category3.id
)

task.save(validate: false)
