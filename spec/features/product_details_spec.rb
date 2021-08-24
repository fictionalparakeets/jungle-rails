require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

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

  scenario "They click on a product and are taken to the product detail" do
    # ACT
    visit root_path

    # visit it and then click one of the product partials in order to navigate directly to a product detail page.
    first('.product').click_on 'Details'

    sleep(10)
    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_css '.col-sm-8'
  end

end
