# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Seeding development database...'
drishti = User.first_or_create!(email: 'drishti31@gmail.com',
                             password: 'password',
                             password_confirmation: 'password',
                             first_name: 'drishit',
                             last_name: 'verma',
                             role: User.roles[:admin])

vision = User.first_or_create!(email: 'vision@gmail.com',
                             password: 'password',
                             password_confirmation: 'password',
                             first_name: 'vision',
                             last_name: 'verma')
Address.first_or_create!(street: '123 Main St',
                         city: 'Anytown',
                         state: 'CA',
                         zip: '12345',
                         country: 'USA',
                         user: drishti)
Address.first_or_create(street: '123 Main St',
                        city: 'Anytown',
                        state: 'CA',
                        zip: '12345',
                        country: 'USA',
                        user: vision)
category = Category.first_or_create!(name: 'Uncategorized', display_in_nav: true)
Category.first_or_create!(name: 'General', display_in_nav: true)
Category.first_or_create!(name: 'Finance', display_in_nav: true)
Category.first_or_create!(name: 'Health', display_in_nav: false)
Category.first_or_create!(name: 'Education', display_in_nav: false)
elapsed = Benchmark.measure do
  posts = []
  10.times do |x|
    puts "Creating post #{x}"
    post = Post.new(title: "Title #{x}",
                    body: "Body #{x} Words go here Idk",
                    user: drishti,
                    category: category)

    5.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post.comments.build(body: "Comment #{y}",
                          user: vision)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)
end

puts "Seeded development DB in #{elapsed.real} seconds"