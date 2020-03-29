class AdminController < ApplicationController

    def admin_index
        @user = User.find(params[:id])
        @collections = Collection.for_user(@user)
        render "admin_index"
      end
    
end
