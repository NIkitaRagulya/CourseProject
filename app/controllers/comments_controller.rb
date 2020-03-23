class CommentsController < ApplicationController

    def new 
        @comment = Comment.new
    end 

    def create
        @comment = Comment.new(comment_params.merge(item_id: $item, name: current_user.name))
        if @comment.save
            redirect_to item_path($item)
        else
            render 'new'
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:name, :description)
    end

end
