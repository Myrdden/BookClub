require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when i visit a books show page" do
    xit "can create a new review" do
      title = "title 1"
      review = "test review"
      rating = 4
      user_name = "william"
      book = Book.create!(title: "Harry Potter and the Prisoner of Azkaban", page_count: 1234 , year_published: "2010-01-01" , image_url: "https://pics.cdn.librarything.com/picsizes/dd/b9/ddb96bc09edd9c6593241315251434f414f4141.jpg" )

      visit "/reviews/new"

      fill_in "review[title]", with: title
      fill_in "review[username]", with: user_name
      fill_in "review[rating]", with: rating
      fill_in "review[review]", with: review
      
      find("#submit-link", visible: false).click
      
      # expect(current_path).to eq("/books/#{book.id}")
      # expect(page).to have_content(user_name.titleize)
      # expect(page).to have_content(page_count)
    end
  end
end
