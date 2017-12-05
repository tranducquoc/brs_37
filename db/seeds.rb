User.create!(
  full_name: "admin",
  email: "admin@gmail.com",
  password: "zxczxc",
  password_confirmation: "zxczxc",
  avatar: "app/assets/images/admin.jpg",
  is_admin: true,
  activated: true,
  activated_at: Time.zone.now
)

49.times do |n|
  name = Faker::Name.name
  email = "user#{n+1}@gmail.com"
  password = "zxczxc"
  avatar = "app/assets/images/user.png"
  User.create!(
    full_name: name,
    email: email,
    password: password,
    password_confirmation: password,
    avatar: avatar,
    activated: true,
    activated_at: Time.zone.now
  )
end

50.times do |n|
  title = "book name #{n+1}"
  publish_date = Time.zone.now
  author = Faker::Name.name
  the_number_of_pages = 20 + Random.rand(300)
  summary = "This is summary of this book"
  cover_image = "app/assets/images/cover_image.png"
  rating = 1 + Random.rand(4)
  Book.create!(
    title: title,
    publish_date: publish_date,
    author: author,
    the_number_of_pages: the_number_of_pages,
    summary: summary,
    cover_image: cover_image,
    rating: rating
  )
end
