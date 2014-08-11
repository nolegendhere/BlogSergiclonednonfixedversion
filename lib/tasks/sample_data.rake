namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "admin",
                         email: "admin@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true,
                         coadmin: true,
                         colaborator: true) 
    coadmin = User.create!(name: "coadmin",
                         email: "coadmin@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: false,
                         coadmin: true,
                         colaborator: true)
    colaborator = User.create!(name: "colaborator",
                         email: "colaborator@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: false,
                         coadmin: false,
                         colaborator: true)                     
    10.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    3.times do
      title = "Hola"
      content = Faker::Lorem.sentence(5)
      admin.posts.create!(title: title, 
                         content: content)
    end   
        
  end
end