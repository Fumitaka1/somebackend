module V1
  class CommentsController < ApplicationController
    before_action :authenticate_v1_user!, only: %i[create update destroy]
    before_action :set_comment, only: %i[show update destroy]
    before_action -> { check_permission(@comment.user) }, only: %i[edit update destroy]

    def index
      comments = Comment.all.paginate(page: params[:page])
      render json: { status: 'SUCCESS', data: comments }
    end

    def create
      comment = current_v1_user.comments.build(comment_params)

      if comment.save
        render json: { status: 'SUCCESS', data: comment }
      else
        render json: { status: 'ERROR', data: comment.errors }
      end
    end

    def show
      render json: { status: 'SUCCESS', data: @comment }
    end

    def update
      if @comment.update_attributes(comment_params)
        render json: { status: 'SUCCESS', message: 'Updated the comment', data: @comment }
      else
        render json: { status: 'ERROR', message: 'Not updated', data: @comment.errors }
      end
    end

    def destroy
      @comment.destroy
      render json: { status: 'SUCCESS', message: 'Deleted the comment' }
    end

    private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:content, :post_id)
      end
  end
end
