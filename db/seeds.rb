# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 
#
# require 'csv'
#
# PRODUCT_FILE = Rails.root.join('db', 'seed_data', 'product_seeds.csv')
# puts "Loading raw work data from #{PRODUCT_FILE}"
#
# product_failures = []
# CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
#   product = Product.new
#   product.id = row['product_id']
#   product.category_id = row['category_id']
#   product.user_id = row['user_id']
#   product.name = row['name']
#   product.price = row['price']
#   product.description = row['description']
#   puts "Created product: #{product.inspect}"
#   successful = product.save
#   if !successful
#     product_failures << product
#   end
# end
#
# puts "Added #{Product.count} product records"
# puts "#{product_failures.length} product failed to save"
#
# #
# #
# # USER_FILE = Rails.root.join('db', 'seed_data', 'user_seeds.csv')
# # puts "Loading raw user data from #{USER_FILE}"
# #
# # user_failures = []
# # CSV.foreach(USER_FILE, :headers => true) do |row|
# #   user = User.new
# #   user.id = row['user_id']
# #   user.name = row['username']
# #   user.email = row['email']
# #   puts "Created user: #{user.inspect}"
# #   successful = user.save
# #   if !successful
# #     user_failures << user
# #   end
# # end
# #
# # puts "Added #{User.count} user records"
# # puts "#{user_failures.length} users failed to save"
# #
# #
# #
# # CATEGORY_FILE = Rails.root.join('db', 'seed_data', 'category_seeds.csv')
# # puts "Loading raw category data from #{CATEGORY_FILE}"
# #
# # category_failures = []
# # CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
# #   category = Category.new
# #   category.id = row['category_id']
# #   category.name = row['name']
# #   puts "Created category: #{category.inspect}"
# #   successful = category.save
# #   if !successful
# #     product_failures << product
# #   end
# # end
# #
# # puts "Added #{Product.count} product records"
# # puts "#{product_failures.length} product failed to save"
# #
# # #
# # #
# # # USER_FILE = Rails.root.join('db', 'seed_data', 'user_seeds.csv')
# # # puts "Loading raw user data from #{USER_FILE}"
# # #
# # # user_failures = []
# # # CSV.foreach(USER_FILE, :headers => true) do |row|
# # #   user = User.new
# # #   user.id = row['user_id']
# # #   user.name = row['username']
# # #   user.email = row['email']
# # #   puts "Created user: #{user.inspect}"
# # #   successful = user.save
# # #   if !successful
# # #     user_failures << user
# # #   end
# # # end
# # #
# # # puts "Added #{User.count} user records"
# # # puts "#{user_failures.length} users failed to save"
# # #
# # #
# # #
# # # CATEGORY_FILE = Rails.root.join('db', 'seed_data', 'category_seeds.csv')
# # # puts "Loading raw category data from #{CATEGORY_FILE}"
# # #
# # # category_failures = []
# # # CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
# # #   category = Category.new
# # #   category.id = row['category_id']
# # #   category.name = row['name']
# # #   puts "Created category: #{category.inspect}"
# # #   successful = category.save
# # #   if !successful
# # #     category_failures << category
# # #   end
# # # end
# # #
# # # puts "Added #{Category.count} category records"
# # # puts "#{category_failures.length} category failed to save"
# # #
# # #
# # #
# # # REVIEW_FILE = Rails.root.join('db', 'seed_data', 'reviews_seeds.csv')
# # # puts "Loading raw review data from #{REVIEW_FILE}"
# # #
# # # review_failures = []
# # # CSV.foreach(REVIEW_FILE, :headers => true) do |row|
# # #   review = Review.new
# # #   review.id = row['review_id']
# # #   review.name = row['user_id']
# # #   review.name = row['product_id']
# # #   review.name = row['text']
# # #   review.name = row['rating']
# # #   puts "Created review: #{review.inspect}"
# # #   successful = review.save
# # #   if !successful
# # #     review_failures << review
# # #   end
# # # end
# # #
# # # puts "Added #{Review.count} review records"
# # # puts "#{review_failures.length} review failed to save"
# # #
# # #
# # #
# # # ORDER_PRODUCT_FILE = Rails.root.join('db', 'seed_data', 'order_products_seeds.csv')
# # # puts "Loading raw order_product data from #{ORDER_PRODUCT_FILE}"
# # #
# # # order_product_failures = []
# # # CSV.foreach(ORDER_PRODUCT_FILE, :headers => true) do |row|
# # #   order_product = Order_Product.new
# # #   order_product.id = row['order_product_id']
# # #   order_product.name = row['order_id']
# # #   order_product.name = row['product_id']
# # #   order_product.name = row['quantity']
# # #   puts "Created review: #{order_product.inspect}"
# # #   successful = order_product.save
# # #   if !successful
# # #     order_product_failures << order_product
# # #   end
# # # end
# # #
# # # puts "Added #{Order_Product.count} order_product records"
# # # puts "#{order_product_failures.length} order_product failed to save"
# # #
# # #
# # #
# # #
# # # ORDER_FILE = Rails.root.join('db', 'seed_data', 'order_seeds.csv')
# # # puts "Loading raw order data from #{ORDER_FILE}"
# # #
# # # order_failures = []
# # # CSV.foreach(ORDER_FILE, :headers => true) do |row|
# # #   order = Order.new
# # #   order.id = row['order_id']
# # #   order.session_id = row['session_id']
# # #   order.product_id = row['product_id']
# # #   order.order_status = row['order_status']
# # #   order.billing_data_id = row['billing_data_id']
# # #   puts "Created order: #{order.inspect}"
# # #   successful = order.save
# # #   if !successful
# # #     order_failures << order
# # #   end
# # # end
# # #
# # # puts "Added #{Order.count} order records"
# # # puts "#{order_failures.length} order failed to save"
# # #
# # #
# # # BILLING_DATA_FILE = Rails.root.join('db', 'seed_data', 'billing_data_seeds.csv')
# # # puts "Loading raw billing_data data from #{BILLING_DATA_FILE}"
# # #
# # # billing_data_failures = []
# # # CSV.foreach(BILLING_DATA_FILE, :headers => true) do |row|
# # #   billing_data = Billing_Data.new
# # #   billing_data.id = row['billing_data_id']
# # #   billing_data.session_id = row['billing_data_id']
# # #   billing_data.product_id = row['billing_data_id']
# # #   billing_data.order_status = row['billing_data_status']
# # #
# # #   puts "Created billing_data: #{billing_data.inspect}"
# # #   successful = billing_data.save
# # #   if !successful
# # #     billing_data_failures << billing_data
# # #   end
# # # end
# # #
# # # puts "Added #{Billing_Data.count} billing_data records"
# # # puts "#{billing_failures.length} billing_data records failed to save"
# # #
# # #
# # #
# # # ITEM_FILE = Rails.root.join('db', 'seed_data', 'items_seeds.csv')
# # # puts "Loading raw item data from #{ITEM_FILE}"
# # #
# # # item_failures = []
# # # CSV.foreach(ITEM_FILE, :headers => true) do |row|
# # #   item = Item.new
# # #   item.id = row['item_id']
# # #   item_data.product_id = row['product_id']
# # #   item_data.shipping_status = row['shipping_status']
# # #   item_data.purchase_status = row['purchase_status']
# # #   item_data.order_id = row['order_id']
# # #
# # #   item_data.order_status = row['item_status']
# # #
# # #   puts "Created item: #{item.inspect}"
# # #   successful = item.save
# # #   if !successful
# # #     item_failures << item
# # #   end
# # # end
# # #
# # # puts "Added #{Item.count} item records"
# # # puts "#{item_failures.length} item records failed to save"
# # #
# #
# # # Since we set the primary key (the ID) manually on each of the
# # # tables, we've got to tell postgres to reload the latest ID
# # # values. Otherwise when we create a new record it will try
# # # to start at ID 1, which will be a conflict.
# # puts "Manually resetting PK sequence on each table"
# # ActiveRecord::Base.connection.tables.each do |t|
# #   ActiveRecord::Base.connection.reset_pk_sequence!(t)
# # end
# #
# # puts "done"
