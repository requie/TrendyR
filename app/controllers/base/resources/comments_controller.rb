module Base
  module Resources
    class CommentsController < Resources::BaseController
      def create
        @commentable = Comment.find_commentable(comment_params[:commentable_type], comment_params[:commentable_id])
        @comment = @commentable.comments.new(comment_params)
        @comment.user = current_user
        @comment.is_active = true
        if @comment.save
          flash[:notice] = "Thanks for the comment."
        else
          flash[:alert] = "You had some errors for your comment."
        end
        redirect_to @commentable
      end

      private

      def comment_params
        params.require(:comment).permit(:text, :commentable_id, :commentable_type)
      end
    end
  end
end