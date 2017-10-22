#This file should contain all the record creation needed to seed the database with its default values.
#The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


require 'csv'

USER_FILE = Rails.root.join('db', 'seed_data', 'user_seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.id = row['user_id']
  user.username = row['username']
  user.email = row['email']
  puts "Created user: #{user.inspect}"
  successful = user.save
  if !successful
    user_failures << user
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

user_failures.each do |failure|
  failure.errors.each do |error, message|
    puts "Error: #{error}; Message: #{message}"
  end
end

puts " "
puts "--------------------------------------"
puts " "

PRODUCT_FILE = Rails.root.join('db', 'seed_data', 'product_seeds.csv')
puts "Loading raw work data from #{PRODUCT_FILE}"

product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.id = row['product_id']
  product.name = row['name']
  product.price = row['price']
  product.description = row['description']
  product.user_id = row['user_id']

  puts "Created product: #{product.inspect}"
  successful = product.save
  if !successful
    product_failures << product
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} product failed to save"
product_failures.each do |failure|
  failure.errors.each do |error, message|
    puts "Error: #{error}; Message: #{message}"
  end
end

puts " "
puts "--------------------------------------"
puts " "


CATEGORY_FILE = Rails.root.join('db', 'seed_data', 'category_seeds.csv')
puts "Loading raw category data from #{CATEGORY_FILE}"

category_failures = []
CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.id = row['category_id']
  category.name = row['name']
  puts "Created category: #{category.inspect}"
  successful = category.save
  if !successful
    category_failures << category
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} categories failed to save"

puts " "
puts "--------------------------------------"
puts " "


REVIEW_FILE = Rails.root.join('db', 'seed_data', 'reviews_seeds.csv')
puts "Loading raw review data from #{REVIEW_FILE}"

review_failures = []
CSV.foreach(REVIEW_FILE, :headers => true) do |row|
  review = Review.new
  review.id = row['review_id']
  review.text = row['text']
  review.rating = row['rating']
  review.user_id = row['user_id']
  review.product_id = row['product_id']
  puts "Created review: #{review.inspect}"
  successful = review.save
  if !successful
    review_failures << review
  end
end

puts "Added #{Review.count} review records"
puts "#{review_failures.length} review failed to save"

puts " "
puts "--------------------------------------"
puts " "


BILLING_DATA_FILE = Rails.root.join('db', 'seed_data', 'billing_data_seeds.csv')
puts "Loading raw billing_data data from #{BILLING_DATA_FILE}"

billing_data_failures = []
CSV.foreach(BILLING_DATA_FILE, :headers => true) do |row|
  billing_datum = BillingDatum.new
  billing_datum.id = row['billing_data_id']
  billing_datum.email = row['email']
  billing_datum.mailing_address = row['mailing_address']
  billing_datum.credit_card_name = row['credit_card_name']
  billing_datum.credit_card_number = row['credit_card_number']
  billing_datum.credit_card_cvv = row['credit_card_cvv']
  billing_datum.billing_zip_code = row['billing_zip_code']
  billing_datum.user_id = row['user_id']

  puts "Created billing_datum: #{billing_datum.inspect}"
  successful = billing_datum.save
  if !successful
    billing_data_failures << billing_datum
  end
end

puts "Added #{BillingDatum.count} billing_data records"
puts "#{billing_data_failures.length} billing_data records failed to save"

puts " "
puts "--------------------------------------"
puts " "


ORDER_FILE = Rails.root.join('db', 'seed_data', 'order_seeds.csv')
puts "Loading raw order data from #{ORDER_FILE}"

order_failures = []
CSV.foreach(ORDER_FILE, :headers => true) do |row|
  order = Order.new
  order.id = row['order_id']
  order.order_status = row['order_status']
  order.user_id = row['user_id']
  order.session_id = row['session_id']
  order.billing_datum_id = row['billing_data_id']
  puts "Created order: #{order.inspect}"
  successful = order.save
  if !successful
    order_failures << order
  end
end

puts "Added #{Order.count} order records"
puts "#{order_failures.length} order failed to save"

puts " "
puts "--------------------------------------"
puts " "


ORDER_PRODUCTS_FILE = Rails.root.join('db', 'seed_data', 'order_products_seeds.csv')
puts "Loading raw order_product data from #{ORDER_PRODUCTS_FILE}"

order_product_failures = []
CSV.foreach(ORDER_PRODUCTS_FILE, :headers => true) do |row|
  order_product = OrderProduct.new
  order_product.id = row['order_product_id']
  order_product.order_id = row['order_id']
  order_product.product_id = row['product_id']
  order_product.quantity = row['quantity']
  puts "Created review: #{order_product.inspect}"
  successful = order_product.save
  if !successful
    order_product_failures << order_product
  end
end

puts "Added #{OrderProduct.count} order_product records"
puts "#{order_product_failures.length} order_products failed to save"


puts " "
puts "--------------------------------------"
puts " "


ITEM_FILE = Rails.root.join('db', 'seed_data', 'items_seeds.csv')
puts "Loading raw item data from #{ITEM_FILE}"

item_failures = []
CSV.foreach(ITEM_FILE, :headers => true) do |row|
  item = Item.new
  item.id = row['item_id']
  item.shipping_status = row['shipping_status']
  item.purchase_status = row['purchase_status']
  item.product_id = row['product_id']
  item.order_id = row['order_id']

  puts "Created item: #{item.inspect}"
  successful = item.save
  if !successful
    item_failures << item
  end
end

puts "Added #{Item.count} item records"
puts "#{item_failures.length} item records failed to save"

puts " "
puts "--------------------------------------"
puts " "
#
# # Since we set the primary key (the ID) manually on each of the
# # tables, we've got to tell postgres to reload the latest ID
# # values. Otherwise when we create a new record it will try
# # to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
