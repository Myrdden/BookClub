require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when i visit a books new page" do
    xit "can create a new book and author" do
      title = "title 1"
      page_count = 199
      year_published = 1990
      image_url = "https://pics.cdn.librarything.com/picsizes/dd/b9/ddb96bc09edd9c6593241315251434f414f4141.jpg"
      authors = "new_1, new_2"

      visit "/books/new"

      fill_in "book[title]", with: title
      fill_in "book[pages]", with: page_count
      fill_in "book[year]", with: year_published
      fill_in "book[image]", with: image_url
      fill_in "book[authors]", with: authors
      
      find("#submit-link", visible: false).click

      
      expect(current_path).to eq("/books")
      expect(page).to have_content(title.titleize)
      expect(page).to have_content(page_count)
    end
  end
end
