class SearchController < ApplicationController
    def index
        items = Item.where("name LIKE ?", "%" + params[:q] + "%") 
        comments = Comment.where("description LIKE ?", "%" + params[:q] + "%").collect(&:item_id)
        items1 = Item.where(id: comments).to_a
        collections = Collection.where("description LIKE ?", "%" + params[:q] + "%").collect(&:id)
        items2 = Item.where(collection_id: collections).to_a
        @items = items | items1 | items2 
    end
end