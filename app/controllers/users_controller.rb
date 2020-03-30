class UsersController < ApplicationController

    def index 
        @user = User.find(params[:user_id])
        @collections = Collection.where(user_id: @user.id)
    end

    def new
        @user = User.find(params[:user_id])
        @collection = Collection.new
    end

    def create
        @user = User.find(params[:user_id])
        @collection = Collection.new(collection_params.merge(user_id: @user.id))
        if @collection.save
          redirect_to action: :index
        else
          render 'new'
        end
    end

    def destroy
        @collection.destroy
        redirect_to user_collections_path
    end

end