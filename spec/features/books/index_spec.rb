require 'rails_helper'

RSpec.describe "As a visitor," do
  describe "when visiting books," do
    before :each do
      Book.destroy_all
      Author.destroy_all
      User.destroy_all
      @book1 = Book.create! title: "Book 1", page_count: "100", year_published: "10", image_url: "http://lorempixel.com/400/600/cats"
      @book2 = Book.create! title: "Book 2", page_count: "110", year_published: "20", image_url: "http://lorempixel.com/400/600/cats"
      @book3 = Book.create! title: "Book 3", page_count: "120", year_published: "30", image_url: "http://lorempixel.com/400/600/cats"
      @book4 = Book.create! title: "Book 4", page_count: "130", year_published: "40", image_url: "http://lorempixel.com/400/600/cats"
      @book5 = Book.create! title: "Book 5", page_count: "140", year_published: "50", image_url: "http://lorempixel.com/400/600/cats"

      @author1 = Author.create! name: "A", image_url: "http://lorempixel.com/400/600/cats"
      @author2 = Author.create! name: "B", image_url: "http://lorempixel.com/400/600/cats"
      @author3 = Author.create! name: "C", image_url: "http://lorempixel.com/400/600/cats"
      @author4 = Author.create! name: "D", image_url: "http://lorempixel.com/400/600/cats"
      @author5 = Author.create! name: "E", image_url: "http://lorempixel.com/400/600/cats"

      @author1.books << @book1
      @author2.books << @book2
      @author3.books << @book3
      @author4.books << @book4
      @author5.books << @book5

      @book1_author = "A"
      @book2_author = "B"
      @book3_author = "C"
      @book4_author = "D"
      @book5_author = "E"

      @reviewinator = User.create! username: "Reviewinator"
      @reviewinator.reviews.create! title: 'It was A book', review: 'hec', rating: 5, book_id: @book1.id
      @reviewinator.reviews.create! title: 'It was A book', review: 'hec', rating: 5, book_id: @book1.id
      @reviewinator.reviews.create! title: 'It was A book', review: 'hec', rating: 5, book_id: @book1.id
      @reviewinator.reviews.create! title: 'It was A book', review: 'hec', rating: 5, book_id: @book1.id
      @reviewinator.reviews.create! title: 'It was B book', review: 'hecc', rating: 4, book_id: @book2.id
      @reviewinator.reviews.create! title: 'It was B book', review: 'hecc', rating: 4, book_id: @book2.id
      @reviewinator.reviews.create! title: 'It was B book', review: 'hecc', rating: 4, book_id: @book2.id
      @reviewinator.reviews.create! title: 'It was C book', review: 'heccc', rating: 3, book_id: @book3.id
      @reviewinator.reviews.create! title: 'It was C book', review: 'heccc', rating: 3, book_id: @book3.id
      @reviewinator.reviews.create! title: 'It was D book', review: 'hecccc', rating: 2, book_id: @book4.id
    end

    it "can link to other indexes" do
      visit "/books"

      click_link "Books"
      expect(current_path).to eq "/books"

      visit "/books"
      click_link "Authors"
      expect(current_path).to eq "/authors"

      visit "/books"
      click_link "Users"
      expect(current_path).to eq "/users"
    end

    xit "sees a title" do
      visit "/books"

      within("#book-title-#{@book1.id}") do
        expect(page).to have_content(@book1.title)
      end
      within("#book-title-#{@book2.id}") do
        expect(page).to have_content(@book2.title)
      end
      within("#book-title-#{@book3.id}") do
        expect(page).to have_content(@book3.title)
      end
      within("#book-title-#{@book4.id}") do
        expect(page).to have_content(@book4.title)
      end
      within("#book-title-#{@book5.id}") do
        expect(page).to have_content(@book5.title)
      end
    end

    it "sees an author and page count" do
      visit "/books"

      within("#book-content-#{@book1.id}") do
        expect(page).to have_content(@book1_author)
        expect(page).to have_content(@book1.page_count)
      end
      within("#book-content-#{@book2.id}") do
        expect(page).to have_content(@book2_author)
        expect(page).to have_content(@book2.page_count)
      end
      within("#book-content-#{@book3.id}") do
        expect(page).to have_content(@book3_author)
        expect(page).to have_content(@book3.page_count)
      end
      within("#book-content-#{@book4.id}") do
        expect(page).to have_content(@book4_author)
        expect(page).to have_content(@book4.page_count)
      end
      within("#book-content-#{@book5.id}") do
        expect(page).to have_content(@book5_author)
        expect(page).to have_content(@book5.page_count)
      end
    end

    it "sees average reviews and review count" do
      visit "/books"

      within("#book-content-#{@book1.id}") do
        expect(page).to have_content(@book1.count_book_reviews)
        expect(page).to have_content(@book1.average_book_rating.round(0))
      end
      within("#book-content-#{@book2.id}") do
        expect(page).to have_content(@book2.count_book_reviews)
        expect(page).to have_content(@book2.average_book_rating.round(0))
      end
      within("#book-content-#{@book3.id}") do
        expect(page).to have_content(@book3.count_book_reviews)
        expect(page).to have_content(@book3.average_book_rating.round(0))
      end
      within("#book-content-#{@book4.id}") do
        expect(page).to have_content(@book4.count_book_reviews)
        expect(page).to have_content(@book4.average_book_rating.round(0))
      end
      within("#book-content-#{@book5.id}") do
        expect(page).to have_content(@book5.count_book_reviews)
        expect(page).to have_content(@book5.average_book_rating.round(0))
      end
    end

    it "has statistics" do
      visit "/books"

      within "#stats-highest-rated" do
        expect(page).to have_content(@book1.title)
        expect(page).to have_content(@book2.title)
        expect(page).to have_content(@book3.title)
      end

      within "#stats-lowest-rated" do
        expect(page).to have_content(@book3.title)
        expect(page).to have_content(@book4.title)
        expect(page).to have_content(@book5.title)
      end
    end

    it "can sort by avg rating" do
      visit "/books?sort=avg_rating"

      within "#left-column" do
        expect(page.all(".card-title")[0]).to have_content(@book5.title)
        expect(page.all(".card-title")[1]).to have_content(@book2.title)
      end
      within "#mid-column" do
        expect(page.all(".card-title")[0]).to have_content(@book4.title)
        expect(page.all(".card-title")[1]).to have_content(@book1.title)
      end
      within "#right-column" do
        expect(page.all(".card-title")[0]).to have_content(@book3.title)
      end

      visit "/books?sort=avg_rating_desc"
      within "#left-column" do
        expect(page.all(".card-title")[0]).to have_content(@book1.title)
        expect(page.all(".card-title")[1]).to have_content(@book4.title)
      end
      within "#mid-column" do
        expect(page.all(".card-title")[0]).to have_content(@book2.title)
        expect(page.all(".card-title")[1]).to have_content(@book5.title)
      end
      within "#right-column" do
        expect(page.all(".card-title")[0]).to have_content(@book3.title)
      end
    end

    it "can sort by page count" do
      visit "/books?sort=num_pages"

      within "#left-column" do
        expect(page.all(".card-title")[0]).to have_content(@book1.title)
        expect(page.all(".card-title")[1]).to have_content(@book4.title)
      end
      within "#mid-column" do
        expect(page.all(".card-title")[0]).to have_content(@book2.title)
        expect(page.all(".card-title")[1]).to have_content(@book5.title)
      end
      within "#right-column" do
        expect(page.all(".card-title")[0]).to have_content(@book3.title)
      end

      visit "/books?sort=num_pages_desc"
      within "#left-column" do
        expect(page.all(".card-title")[0]).to have_content(@book5.title)
        expect(page.all(".card-title")[1]).to have_content(@book2.title)
      end
      within "#mid-column" do
        expect(page.all(".card-title")[0]).to have_content(@book4.title)
        expect(page.all(".card-title")[1]).to have_content(@book1.title)
      end
      within "#right-column" do
        expect(page.all(".card-title")[0]).to have_content(@book3.title)
      end
    end

    it "can sort by num reviews" do
      visit "/books?sort=num_reviews"

      within "#left-column" do
        expect(page.all(".card-title")[0]).to have_content(@book5.title)
        expect(page.all(".card-title")[1]).to have_content(@book2.title)
      end
      within "#mid-column" do
        expect(page.all(".card-title")[0]).to have_content(@book4.title)
        expect(page.all(".card-title")[1]).to have_content(@book1.title)
      end
      within "#right-column" do
        expect(page.all(".card-title")[0]).to have_content(@book3.title)
      end

      visit "/books?sort=num_reviews_desc"
      within "#left-column" do
        expect(page.all(".card-title")[0]).to have_content(@book1.title)
        expect(page.all(".card-title")[1]).to have_content(@book4.title)
      end
      within "#mid-column" do
        expect(page.all(".card-title")[0]).to have_content(@book2.title)
        expect(page.all(".card-title")[1]).to have_content(@book5.title)
      end
      within "#right-column" do
        expect(page.all(".card-title")[0]).to have_content(@book3.title)
      end
    end
  end
end
