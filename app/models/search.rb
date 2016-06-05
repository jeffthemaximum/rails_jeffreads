class Search < ActiveRecord::Base

    attr_accessor :username

    validates :username, presence: true, uniqueness: true

end
