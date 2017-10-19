require 'csv'

MERCHANT_FILE = Rails.root.join('db', 'merchant_seeds.csv')
puts "Loading raw merchant data from #{MERCHANT_FILE}"

merchant_failures = []
CSV.foreach(MERCHANT_FILE, :headers => true) do |row|
  merchant = Merchant.new
  merchant.id = row['id']
  merchant.username = row['username']
  merchant.email = row['email']
  merchant.oauth_uid = row['oauth_uid']
  merchant.oauth_provider = row['provider']
  puts "Created merchant: #{merchant.inspect}"
  successful = merchant.save
  if !successful
    merchant_failures << merchant
  end
end

puts "Added #{Merchant.count} merchant records"
puts "#{merchant_failures.length} merchants failed to save"




PRODUCT_FILE = Rails.root.join('db', 'product_seeds.csv')
puts "Loading raw product data from #{PRODUCT_FILE}"

product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.id = row['id']
  product.name = row['name']
  product.price = row['price']
  product.category = row['category']
  product.merchant_id = row['merchant_id']
  product.quantity = row['quantity']
  puts "Created product: #{product.inspect}"
  successful = product.save
  if !successful
    product_failures << product
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} products failed to save"


ORDER_FILE = Rails.root.join('db', 'order_seeds.csv')
puts "Loading raw order data from #{ORDER_FILE}"

order_failures = []
CSV.foreach(ORDER_FILE, :headers => true) do |row|
  order = Order.new
  order.id = row['id']
  order.customer_email = row['customer_email']
  order.address1 = row['address1']
  order.address2 = row['address2']
  order.city = row['city']
  order.state = row['state']
  order.zipcode = row['zipcode']
  order.cc_name = row['cc_name']
  order.cc_number = row['cc_number']
  order.cc_expiration = row['cc_expiration']
  order.cc_security = row['cc_security']
  order.billingzip = row['billingzip']
  order.status = row['status']
  puts "Created order: #{order.inspect}"
  successful = order.save
  if !successful
    order_failures << order
  end
end

puts "Added #{Order.count} order records"
puts "#{order_failures.length} orders failed to save"


ORDERITEM_FILE = Rails.root.join('db', 'orderitem_seeds.csv')
puts "Loading raw order_item data from #{ORDERITEM_FILE}"

order_item_failures = []
CSV.foreach(ORDERITEM_FILE, :headers => true) do |row|
  order_item = Orderitem.new
  order_item.id = row['id']
  order_item.order_id = row['order_id']
  order_item.product_id = row['product_id']
  order_item.quantity = row['quantity']
  puts "Created order_item: #{order_item.inspect}"
  successful = order_item.save
  if !successful
    order_item_failures << order_item
  end
end

puts "Added #{Orderitem.count} order_item records"
puts "#{order_item_failures.length} order_items failed to save"


# REVIEW_FILE = Rails.root.join('db', 'review_seeds.csv')
# puts "Loading raw review data from #{REVIEW_FILE}"
#
# review_failures = []
# CSV.foreach(REVIEW_FILE, :headers => true) do |row|
#   review = Review.new
#   review.id = row['id']
#   review.product_id = row['product_id']
#   review.review_text = row['review_text']
#   puts "Created review: #{review.inspect}"
#   successful = review.save
#   if !successful
#     review_failures << review
#   end
# end
#
# puts "Added #{Review.count} review records"
# puts "#{review_failures.length} reviews failed to save"

# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
