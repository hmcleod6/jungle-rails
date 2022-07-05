require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do

    before(:each) do
      @category = Category.new
    end

    it "valid if all fields are present" do
      product = Product.new(name: 'Succulent', price: 10, quantity: 5, category: @category)
      expect(product).to be_valid
      expect(product.errors.full_messages).to be_empty
    end

    it "invalid if no name" do
      product = Product.new(name: nil, price: 10, quantity: 5, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Name can't be blank"
    end

    it "invalid if no price" do
      product = Product.new(name: 'Succulent', price: false, quantity: 5, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Price can't be blank"
    end

    it "invalid if no quantity" do
      product = Product.new(name: 'Succulent', price: 10, quantity: nil, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "invalid if no category" do
      product = Product.new(name: 'Succulent', price: 10, quantity: 5, category: nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Category can't be blank"
    end



  end
end 