# Add users
20.times do |t|
  User.create(
    name: "Name #{t}",
    email: "example#{t}@example.com",
    password: '123456',
    password_confirmation: '123456')
end

puts 'Users have been created'

# Add categories
%w[Horror Positive Dramma Comedi Adventure].each do |category_name|
  Category.create(name: category_name)
end

puts 'Catigories have been created'

# Add dreams
User.all.each do |user|
  categories_ids = Category.pluck(:id)

  5.times do |t|
    Dream.create!(
      title: "Dream #{user.id} number #{t}",
      description: 'Test dream description',
      category_id: categories_ids.sample,
      user_id: user.id,
      dream_date: Time.now,
      interval: "22:30-06:30"
    )
  end
end

puts 'Dreams have been created'
