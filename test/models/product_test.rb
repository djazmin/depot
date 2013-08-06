require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any?
  end

  #Validar que el precio del producto sea el esperado
  test "product price must be positive" do
    product = Product.new(:title => "My Book title" ,
                          :description => "yyy", :image => "ejemplo.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')

    product.price = 1
    assert product.valid?
  end
end
