require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it 'should show a new product will save successfully' do
      category_params = {name: 'testCategory'}
      @category = Category.create(category_params)

      product_params = {name: 'testProduct', price: 999.99, quantity: 5, category: @category}
      @product = Product.create(product_params)
      @product.save!

      expect(@product.id).to be_present
    end

    it 'should show that :name exists' do
      category_params = {name: 'testCategory'}
      @category = Category.create(category_params)

      product_params = {name: nil, price: 999.99, quantity: 5, category: @category}

      expect(Product.create(product_params).errors.full_messages).to include("Name can't be blank")
    end


    it 'should show that :price exists' do
      category_params = {name: 'testCategory'}
      @category = Category.create(category_params)

      product_params = {name: 'testProduct', price: nil, quantity: 5, category: @category}

      expect(Product.create(product_params).errors.full_messages).to include("Price can't be blank")
    end


    it 'should show that :category exists' do
      category_params = {name: 'testCategory'}
      @category = Category.create(category_params)

      product_params = {name: 'testProduct', price: 999.99, quantity: 5, category: nil}

      expect(Product.create(product_params).errors.full_messages).to include("Category can't be blank")
    end
    
  end

end
