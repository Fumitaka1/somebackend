module V1
  class PostsController < ApplicationController
    before_action :authenticate_v1_user!, only: %i[create update destroy]
    before_action :set_post, only: %i[show update destroy]
    before_action -> { check_permission(@post.user) }, only: %i[edit update destroy]

    def index
      posts = Post.all.order(id: :desc).paginate(page: params[:page])
      render json: { status: 'SUCCESS', data: posts }
    end

    def create
      post = current_v1_user.posts.build(post_params)

      if post.save
        render json: { status: 'SUCCESS', data: post }
      else
        render json: { status: 'ERROR', data: post.errors }
      end
    end

    def show
      render json: { status: 'SUCCESS', data: @post }
    end

    def update
      if @post.update_attributes(post_params)
        render json: { status: 'SUCCESS', message: 'Updated the post', data: @post }
      else
        render json: { status: 'ERROR', message: 'Not updated', data: @post.errors }
      end
    end

    def destroy
      @post.destroy
      render json: { status: 'SUCCESS', message: 'Deleted the post' }
    end

    private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:content)
      end
  end
end
