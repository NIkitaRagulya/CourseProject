class CommentsController < ApplicationController

    def new 
        @comment = Comment.new
    end 

    def create
        @comment = Comment.new(comment_params.merge(item_id: params[:item_id], name: current_user.name))
        if @comment.save
            redirect_to collection_item_path(params[:collection_id], params[:item_id])
        else
            render 'new'
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:name, :description)
    end

end
