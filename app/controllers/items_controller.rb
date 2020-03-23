class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, except: [:index, :create, :new]

  def index
    @items = Item.for_collection($collection)
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def show
    @comments = Comment.for_item(@item)
    $item = @item.id
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  def create
    @item = Item.new(item_params.merge(collection_id: $collection.id))
   if @item.save
     redirect_to action: :index
   else
     render 'new'
   end
  end

  private

  def set_item
    @item = Item.for_collection($collection).find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :feature_image)
  end

end
