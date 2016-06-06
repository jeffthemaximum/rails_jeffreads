class Search < ActiveRecord::Base

    has_many :book_lists
    has_many :books, through: :book_lists

    attr_accessor :username

    validates :username, presence: true, uniqueness: true

    # https://www.goodreads.com/review/list/4347169.xml?key=4aJ7ZnthsNwaDLR8zefCw&v=2
    
    # try to move all to helpers
    def query_or_api
        books = query(self.username)
    end

    def build_good_url(u_id)
        "https://www.goodreads.com/review/list/" + u_id.to_s + ".xml?key=4aJ7ZnthsNwaDLR8zefCw&v=2&per_page=200"
    end

    def call_good(url)
        require 'open-uri'
        Nokogiri::XML(open(url))
    end

    def get_amazon_link(title)
        Amazon::Ecs.configure do |options|
            options[:AWS_access_key_id] = ENV['AWSAKI']
            options[:AWS_secret_key] = ENV["AWSSK"]
            options[:associate_tag] = 'jeffmaxim-20'
        end
        begin
            return Amazon::Ecs.item_search(title, :search_index => 'All').items[0].get_element('DetailPageURL').get
        rescue Amazon::RequestError
            puts "amazon error!"
        end

    end

    def get_or_create_books(review)
        
        good_id = review.xpath('book').xpath('id').text.to_i
        book = Book.find_or_initialize_by(good_id: good_id)
        if book.new_record?
            nokogiri_book = review.xpath('book')
            book.title = nokogiri_book.xpath('title').text
            book.image_url = nokogiri_book.xpath('image_url').text
            book.good_link = nokogiri_book.xpath('link').text
            book.num_pages = nokogiri_book.xpath('num_pages').text.to_i
            book.format = nokogiri_book.xpath('format').text
            book.publisher = nokogiri_book.xpath('publisher').text
            book.publication_day = nokogiri_book.xpath('publication_day').text.to_i
            book.publication_month = nokogiri_book.xpath('publication_month').text.to_i
            book.publication_year = nokogiri_book.xpath('publication_year').text.to_i
            book.average_rating = nokogiri_book.xpath('average_rating').text.to_i
            book.description = nokogiri_book.xpath('description').text
            nokogiri_book.xpath('authors/author').each do |author|
                book.author_name = author.xpath('name').text
            end
            book.amazon_link = get_amazon_link(book.title)
            book.good_ratings_count = nokogiri_book.xpath('ratings_count')
            book.jeff_user_count = 1
            book.save
            self.book_lists.create(book: book)
        else
            book.jeff_user_count += 1
            book.save
        end
        return book
    end

    def get_u_id(uname)
        url = "https://www.goodreads.com/user/show/?key=4aJ7ZnthsNwaDLR8zefCw&username=" + uname
        doc = call_good(url)
        doc.xpath('//user').xpath('id').text.to_i
    end

    def query
        u_id = get_u_id(self.username) # TODO
        url = build_good_url(u_id)
        doc = call_good(url)
        books = doc.xpath('//review').map {|review| get_or_create_books(review)}
        return books
    end

end
