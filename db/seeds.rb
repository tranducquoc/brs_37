User.create!(
  full_name: "admin",
  email: "admin@gmail.com",
  password: "zxczxc",
  password_confirmation: "zxczxc",
  avatar: "admin.jpg",
  is_admin: true,
  activated: true,
  activated_at: Time.zone.now
)

49.times do |n|
  name = Faker::Name.name
  email = "user#{n+1}@gmail.com"
  password = "zxczxc"
  avatar = "user.png"
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
  title = Faker::Book.title
  publish_date = Time.zone.now
  author = Faker::Book.author
  the_number_of_pages = 20 + Random.rand(300)
  summary = Faker::Lorem.paragraph
  cover_image = "cover_image.png"
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

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

users = User.order(:created_at).take(6)
5.times do |n|
  users.each { |user| user.buy_requests.create!(book_id: n+1, request_status: 0)}
end
