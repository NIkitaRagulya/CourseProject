class MainPageController < ApplicationController
  def index
    @items = Item.all.order(created_at: :desc)
    @collections = Collection.all.order(items_quantity: :desc)
  end
end
