require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
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
  def new_product(image)
    Product.new(:title => "My Book Title", :description => "yyy", :price => 1, :image => image)
  end
  test "image url" do
    ok = %w{fred.jpg fred.gif fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad = %w{fred.doc fred.gif/more fred.gif.more}
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(:title => products(:ruby).title, :description => "yyy", :price => 1, :image => "fred.gif")
    assert !product.save
    assert_equal I18n.translate('activerecord.errorss.messages.taken'), product.errors[:title].join('; ')
  end
end
