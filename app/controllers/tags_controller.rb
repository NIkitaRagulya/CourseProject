class TagsController < ApplicationController
    def show
        @tag = Tag.find_by(name: params[:id])
        @items = @tag.items
    end
end