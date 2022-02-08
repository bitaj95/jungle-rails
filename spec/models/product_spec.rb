require 'rails_helper'
RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves a new product if all four fields are valid' do
      @category = Category.new(name:"Sheep")
      @product = Product.new(name: 'fl00f', description: 'cute n fl00fy', price_cents: 1000, quantity:13, category_id:@category.id)
      @product.save
      
      expect(@product.name).to eq('fl00f')
      expect(@product.description).to eq('cute n fl00fy')
      expect(@product.price_cents).to eq(1000)
      expect(@product.quantity).to eq(13)
      expect(@product.category_id).to eq(@category.id)
    end
    
    it 'is not valid without a name' do
      @category = Category.new
      @product = Product.new(description: 'cute n fl00fy', price_cents: 1000, quantity:13, category_id:@category.id)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Name can't be blank"
    end
    
    it 'is not valid without a price' do
      @category = Category.new
      @product = Product.new(description: 'cute n fl00fy', quantity:13, category_id:@category.id)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Price cents is not a number"
    end
    
    it 'is not valid without a quantity' do
      @category = Category.new
      @product = Product.new(name: 'fl00f', description: 'cute n fl00fy', price_cents: 1000, category_id:@category.id)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Quantity can't be blank"
    end

    it 'is not valid without a category' do
      @category = Category.new
      @product = Product.new(name: 'fl00f', description: 'cute n fl00fy',  quantity:13, price_cents: 1000)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Category can't be blank"
    end


  end
end

