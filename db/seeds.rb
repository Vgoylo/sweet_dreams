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

# Add tags
%w[cool happy sience horror funny interesting].each do |tag_name|
  Tag.create!(name: tag_name)
end

puts 'Tags have been created'


# Add dreams
User.all.each do |user|
  categories_ids = Category.pluck(:id)
  tags = Tag.all
  5.times do |t|
    dream = Dream.create!(
      title: "Dream #{user.id} number #{t}",
      description: 'Test dream description ' * 25,
      category_id: categories_ids.sample,
      user_id: user.id,
      dream_date: Time.now,
      interval: "22:30-06:30"
    )

    tags.sample(2).each do |tag|
      DreamTag.create!(dream_id: dream.id, tag_id: tag.id)
    end
  end
end

puts 'Dreams have been created'

# Add comments
all_users_ids = User.pluck(:id)
Dream.all.each do |dream|
  user_id = dream.user_id
  commented_users_ids = all_users_ids - [user_id]

  commented_users_ids.sample(3).each do |comment_user_id|
    comment = Comment.new

    comment.text = "Commented by #{comment_user_id}" * (10..15).to_a.sample
    comment.user_id = comment_user_id
    comment.dream = dream

    comment.save!
  end
end

puts 'Comments have been created'
