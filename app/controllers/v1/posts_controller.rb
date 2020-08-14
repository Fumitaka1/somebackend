module V1
  class PostsController < ApplicationController
    before_action :set_post, only: %i[show update destroy]

    def index
      posts = Post.all
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
    end

    def update
    end

    def destroy
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
