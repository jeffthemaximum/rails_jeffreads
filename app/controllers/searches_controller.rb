require 'github_user.rb'

class SearchesController < ApplicationController

    def index
        @search = Search.new
    end

    def create
        binding.pry
        username = Search.new(search_params)
        books = username.query_or_api

    end

    private
        def search_params
            params.require(:search_form).permit(:username)
        end
end
