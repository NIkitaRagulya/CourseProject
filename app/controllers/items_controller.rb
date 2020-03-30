class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, except: [:index, :create, :new, :admin_new]

  def index  
    @collection = Collection.find(params[:collection_id])
    @items = Item.for_collection(@collection)
  end

  def new
    @item = Item.new
  end

  def admin_new
    @item = Item.new
  end

  def edit
  end

  def show
    @comments = Comment.for_item(@item)
  end

  def destroy
    @item.destroy
    if params[:user_id].nil?
      redirect_to collection_items_path(@item.collection_id)
    else 
      redirect_to user_collection_items_path(@item.user_id, @item.collection_id)
    end
  end

  def create
    @collection = Collection.find(params[:collection_id])
    if params[:user_id].nil?
      @item = Item.new(item_params.merge(collection_id: @collection.id, user_id: current_user.id))
      if @item.save
        redirect_to action: :index
      else
        render 'new'
      end
    else
      @item = Item.new(item_params.merge(collection_id: @collection.id, user_id: params[:user_id]))
      if @item.save
        redirect_to user_collection_items_path
      else
        render 'new'
      end
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
