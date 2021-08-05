# Create a main sample user.
User.create!(name: Settings.user.admin.name,
             email: Settings.user.admin.email,
             password: Settings.user.admin.password,
             password_confirmation: Settings.user.admin.password,
             admin: true)

# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  User.create!(name: name,
               email: email,
               password: Settings.user.faker.password,
               password_confirmation: Settings.user.faker.password)
end
