#Enable to invoke the Rake task as follows: 
# rake db:reset
# rake db:populate
# rake db:test:prepare
namespace :db do 
  desc "Fill database with sample data"
  task populate: :environment do        #Ensures that the rake task has access to the Rails environment (including the user nmodel)
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    
    admin = User.create!(name: "Francois Malinowski",
                         email: "francois.malinowski@appfolio.com",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
                 
    99.times do |n|      
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end