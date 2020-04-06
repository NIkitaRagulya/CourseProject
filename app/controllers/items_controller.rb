class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, except: [:index, :create, :new, :admin_new, :upvote, :downvote]

  def index  
    @items = Item.where(collection_id: params[:collection_id]).length
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

  def admin_edit
    @item = Item.find(params[:id])
  end

  def update
    if params[:user_id].nil?
      @item = Item.find(params[:id])
      if @item.update(item_params)
        redirect_to collection_items_path
       else
        render 'edit'
       end
    else
      @item = Item.find(params[:id])
      if @item.update(item_params)
        redirect_to user_collection_items_path
       else
        render 'edit'
       end
    end
  end

  def show
    @comments = Comment.for_item(@item)
    respond_to do |format|
      format.json { render json: {data: @comments} }
      format.html
    end
  end

  def comments
    @comments = Comment.for_item(@item)
    render json: @comments
  end

  def destroy
    Tagging.where(item_id: @item.id).delete_all
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
        Collection.update(params[:collection_id], items_quantity: Item.where(collection_id: params[:collection_id]).length)
        redirect_to action: :index
      else
        render 'new'
      end
    else
      @item = Item.new(item_params.merge(collection_id: @collection.id, user_id: params[:user_id]))
      if @item.save
        Collection.update(params[:collection_id], items_quantity: Item.where(collection_id: params[:collection_id]).length)
        redirect_to user_collection_items_path
      else
        render 'new'
      end
    end
  end

  def upvote
    @item = Item.find(params[:id])
    @item.upvote_from current_user
    redirect_to action: :index
  end

  def downvote
    @item = Item.find(params[:id])
    @item.downvote_from current_user
    redirect_to action: :index
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :feature_image, :all_tags, :author, :brand, :year_of_publishing)
  end

end
