# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admins = User.create(
  :first_name            => "admin",
  :last_name             => "first",
  :contact_no            => "1234567890",
  :email                 => "admin@mailinator.com",
  :password              => "12345678",
  :address               => "nanda nagar",
  :city                  => "indore",
  :state                 => "mp",
  :country               => "india",
  :zipcode               => "452001",
  :role                  =>  0
)
