class CollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :main]

  def index
    if params[:user_id].nil?
      @collections = Collection.for_user(current_user)
    else
        @user = User.find(params[:user_id])
        @collections = Collection.for_user(@user)
    end
  end

  def new
    @collection = Collection.new
  end

  def admin_new
    @collection = Collection.new
  end

  def show
    redirect_to collection_items_path
  end

  def edit
      @collection = Collection.for_user(current_user).find(params[:id])
  end

  def admin_edit
      @user = User.find(params[:user_id])
      @collection = Collection.for_user(@user).find(params[:id])
  end

  def update
    if params[:user_id].nil?
      @collection = Collection.for_user(current_user).find(params[:id])
      if @collection.update(collection_params)
        redirect_to collections_path
       else
        render 'edit'
       end
    else
      @user = User.find(params[:user_id])
      @collection = Collection.for_user(@user).find(params[:id])
      if @collection.update(collection_params)
        redirect_to user_collections_path
       else
        render 'edit'
       end
    end
  end

  def create
    if params[:user_id].nil?
      @collection = Collection.new(collection_params.merge(user_id: current_user.id))
      if @collection.save
        redirect_to action: :index
      else
        render 'new'
      end
    else
      @collection = Collection.new(collection_params.merge(user_id: params[:user_id]))
      if @collection.save
        redirect_to user_collections_path
      else
        render 'new'
      end
    end
  end

  def destroy
    if params[:user_id].nil?
      @collection = Collection.for_user(current_user).find(params[:id])
      @collection.destroy
      Item.where(collection_id: @collection.id).delete_all
      redirect_to collections_path
    else
      @user = User.find(params[:user_id])
      @collection = Collection.for_user(@user).find(params[:id])
      @collection.destroy
      Item.where(collection_id: @collection.id).delete_all
      redirect_to user_collections_path
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :topic, :description, :feature_image)
  end

end
