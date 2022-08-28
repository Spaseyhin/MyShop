require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attriute must not be empty" do
    #свойтвства товара не должна оставаться пустым
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
  # цена товара должна быть положительной
  product = Product.new(title:"My Book Title",
                        description: "description",
                        image_url:   "image.jpg")
  product.price = -1
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01"],
  #должна быть больше или равна 0.01
  product.errors[:price]
  product.price = 0
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
  product.price = 1
  assert product.valid?
  end

  def new_product(image_url)
    Product.new(          title:"My Book Title",
                          description: "description",
                          price: 1,
                          image_url:   image_url)
  end

  test "image url" do
    #url изображение
    ok =%w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg https://a.b.c/x/y/z/fred.gif}
    bad =%w{fred.sss fred.gif/more fred.gif.more}

    ok.each do |name|
      assert new_product(name).valid?,"#{name} shouldn't be invalid"
      #должно быть приемлемым
    end
    bad.each do |name|
      assert new_product(name).invalid?,"#{name} sholdn't be valid"
      #должен быть не приемлемым
    end
  end

  test "produce is not valid without a unique title" do
    #если у товара нет уникального названия то он не допустим
    product = Product.new(title:products(:ruby).title,
    description: "yyy",
    price: 1,
    image_url: "fred.gif")

    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
    #уже было использовано
  end


end
