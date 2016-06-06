class Book < ActiveRecord::Base

    has_many :book_lists
    has_many :searches, through: :book_lists

end
