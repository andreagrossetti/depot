require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	test "products attributes must not be empty" do
		product = Product.new
		assert product.invalid?	
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?	
	end

	test "product price must be positive" do
		product = Product.new(title: "Edge of Eternity", description: "A historical novel", image_url: "url.jpg")
		product.price = -1
		assert product.invalid?	
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
		# valid 
		product.price = 1
		assert product.valid? 
	end

	def new_product	image_url
		Product.new(title: "Edge of Eternty", description: "A historical novel", image_url: image_url, price: 10)
	end

	test "The title must be unique" do
		product = Product.new(title: products(:this_changes_everything).title, description: "whatever", price: 20, image_url: "url.jpg")
		assert product.invalid?
		assert product.errors[:title].any?
	end

	test "image url" do
		valid_urls = %w{ hello.gif hello.png hello.jpg http://hello.com/image.jpg }
		invalid_urls = %w{ hello hello.mp4 hello.jpg/more }
		
		valid_urls.each do |url|
			product = new_product(url)
			assert product.valid?, "#{url} should be valid"
		end

		invalid_urls.each do |url|
			product = new_product(url)
			assert product.invalid?, "#{name} should be invalid"
			assert product.errors[:image_url].any? 
		end
	end
end
