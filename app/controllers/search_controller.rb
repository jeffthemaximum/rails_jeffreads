require 'github_user.rb'

class SearchController < ApplicationController

    def index
        @github_user_form = SearchForm.new
    end

    def create
        username = SearchForm.new(search_params)
        
    end

    private
        def search_params
            params.require(:search_form).permit(:username)
        end
end
