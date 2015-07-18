# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
danny = User.where(first_name: "Danny", last_name: "Burt", email: "Danny@Danny.com").first_or_create!(password: "passwordpassword")
isis = User.where(first_name: "Isis", last_name: "Anchalee", email: "Isis@isis.com", admin: true, is_company: true).first_or_create!(password: "passwordpassword")
rando = User.where(first_name: "Rando", last_name: "Yup", email: "u@asdfis.com", is_company: true).first_or_create!(password: "passwordpassword")

UserProfile.where(user_id: danny.id).first_or_create!
CompanyProfile.where(user_id: isis.id, name: "Isis company", description: "Isis company description").first_or_create!
CompanyProfile.where(user_id: rando.id, name: "Rando company", description: "Rando company description").first_or_create!

danny_project = Project.where(title: "Danny project", description: "My project yo'", time_line: 6, user_id: danny.id, complexity: 50, price: 50).first_or_create!
isis_bid = Bid.where(project_id: danny_project.id, price: 100, bidder_id: isis.id, content: "Plz accept").first_or_create!
rando_bid = Bid.where(project_id: danny_project.id, price: 1000, bidder_id: rando.id, content: "Plz accept11!1").first_or_create!

isis_review = Review.where(reviewer_id: danny.id, reviewed_id: isis.id, title: "review", body: "good job", rating: 5, project_id: danny_project.id)
rando_review = Review.where(reviewer_id: danny.id, reviewed_id: rando.id, title: "review", body: "good job", rating: 1, project_id: danny_project.id)


