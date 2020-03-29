class CollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :main]
  before_action :set_collection, except: [:index, :create, :new, :show, :main, :admin_index]

  def index
    @collections = Collection.for_user(current_user)
  end

  def admin_index
    user = User.find(params[:user_id])
    @collections = Collection.for_user(user)
  end

  def new
    @collection = Collection.new
  end

  def show
    redirect_to collection_items_path
  end

  def edit
  end

  def update
    if @collection.update(collection_params)
     redirect_to action: :index
    else
     render 'edit'
    end
  end

  def create
    
      @collection = Collection.new(collection_params.merge(user_id: collection.user_id))
      if @collection.save
        redirect_to action: :index
      else
        render 'new'
      end
  end

  def destroy
    @collection.destroy
    redirect_to collections_path
  end

  private

  def set_collection
    @collection = Collection.for_user(current_user).find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :topic, :description, :feature_image)
  end

end
