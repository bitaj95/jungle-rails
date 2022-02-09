require 'rails_helper'

RSpec.feature "Users can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Cart number increases by one after clicking the 'Add' button" do
    # ACT
    visit root_path
    expect(page).to have_content("My Cart (0)")
    page.find('.products').first(:button,'Add').click
    sleep 5

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content("My Cart (1)")
    #page.has_css?('nav[data-role="primary-navigation"] li', text: 'FAQ')
  end
end