class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, except: [:index, :create, :new]

  def index
    @collection = Collection.find(params[:collection_id])
    @items = Item.for_collection(@collection)
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def show
    @comments = Comment.for_item(@item)
  end

  def destroy
    @item.destroy
    redirect_to collection_items_path(@item.collection_id)
  end

  def create
    @collection = Collection.find(params[:collection_id])
    @item = Item.new(item_params.merge(collection_id: @collection.id, user_id: current_user.id))
   if @item.save
     redirect_to action: :index
   else
     render 'new'
   end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :feature_image)
  end

end
