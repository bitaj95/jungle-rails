require 'rails_helper'

RSpec.feature "Users can navigate from the home page to the product detail page", type: :feature, js: true do

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


  scenario "They see product detail page" do
    # ACT
    visit root_path
    #first('.actions').click_on('Details')
    page.find('.products').first(:link,'Details').click 
    sleep 5
    puts page.html

    # DEBUG / VERIFY
    save_screenshot

    # VERIFY
    expect(page).to have_css 'section.products-show'
  end

end