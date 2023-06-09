# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.new(email: "admin@email.com", fname: "daniel", mname: "nav", lname: "calingo", contacts: "secret", address: "secret").save
Authentication.signup(email: "admin@email.com", username: "admin", password: "12345678")
admin = Authentication.find_by(username: "admin")
admin.update(user_level: 2)

User.create_user({:username => "danielc", :password => "12345678", :email => "daniel@email.com", :status => "approved"})
User.create_user({:username => "henri", :password => "12345678", :email => "henri@email.com", :status => "approved"})