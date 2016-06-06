class BookList < ActiveRecord::Base
  belongs_to :book
  belongs_to :search
end
