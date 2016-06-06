require 'github_user.rb'

class SearchesController < ApplicationController

    def index
    end

    def new
        @search = Search.new
    end

    def create
        search = Search.new(search_params)
        search.save
        @books = search.query
        render 'index'
    end

    private
        def search_params
            params.require(:search).permit(:username)
        end
end
