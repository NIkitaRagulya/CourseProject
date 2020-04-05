class MainPageController < ApplicationController
  def index
    @collections = Collection.all.order(created_at: :desc)
    @collections1 = Collection.all.order(items_quantity: :desc)
  end
end
