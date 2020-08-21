# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts', type: :request do
  let(:article) { create(:post) }
  let(:user) { create(:user) }
  describe 'GET #index' do
    before { create_list(:post, 40) }
    it '投稿を30件返す' do
      get '/v1/posts'
      response_json = JSON.parse(response.body)

      expect(response_json['status']).to eq 'SUCCESS'
      expect(response_json['data'].length).to eq 30
    end
  end

  describe 'GET #show' do
    it '記事詳細ページが表示されること' do
      get "/v1/posts/#{article.id}"
      response_json = JSON.parse(response.body)


      expect(response_json['status']).to eq 'SUCCESS'
      expect(response_json['data']['content']).to eq article.content
    end
  end

  describe 'PATCH #update' do
    context 'auth_tokensを含む場合' do
      let(:auth_tokens) { sign_in(user) }
      context '投稿の所有者の場合' do
        let(:own_article) { create(:post, user_id: user.id) }
        it '更新された投稿が返されること' do
          patch "/v1/posts/#{own_article.id}",
            params: { post: {content: 'changed' }},
            headers: auth_tokens

          response_json = JSON.parse(response.body)

          expect(response_json['status']).to eq 'SUCCESS'
          expect(response_json['data']['content']).to eq 'changed'
        end
      end
      context '投稿の所有者でない場合' do
        it 'エラーが返されること' do
          patch "/v1/posts/#{article.id}",
            params: { post: {content: 'changed' }},
            headers: auth_tokens

          response_json = JSON.parse(response.body)

          expect(response.status).to eq 403
          expect(response_json['status']).to eq 'ERROR'
        end
      end
    end
    context 'auth_tokensを含まない場合' do
      it '401を返すこと' do
        patch "/v1/posts/#{article.id}", params: { post: {content: 'changed' }}

        expect(response.status).to eq 401
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしている場合' do
      let(:auth_tokens) { sign_in(user) }
      it '作成された投稿が返されること' do
        post '/v1/posts',
          params: { post: {content: 'sample' }},
          headers: auth_tokens

        response_json = JSON.parse(response.body)

        expect(response_json['status']).to eq 'SUCCESS'
        expect(response_json['data']['content']).to eq 'sample'
      end
    end

    context 'auth_tokensを含まない場合' do
      it '401を返すこと' do
        post '/v1/posts', params: { post: {content: 'sample' }}
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしている場合' do
      let(:auth_tokens) { sign_in(user) }
      context '投稿の所有者の場合' do
        let(:own_article) { create(:post, user_id: user.id) }
        it 'メッセージDeleted the postが返されること' do
          delete "/v1/posts/#{own_article.id}", headers: auth_tokens
          response_json = JSON.parse(response.body)

          expect(response_json['status']).to eq 'SUCCESS'
          expect(response_json['message']).to eq 'Deleted the post'
        end
        it 'インスタンスが削除されること' do
          own_article
          expect do
            delete "/v1/posts/#{own_article.id}", headers: auth_tokens
          end.to change { Post.count }.by(-1)
        end
      end
      context '投稿の所有者でない場合' do
        it '403を返すこと' do
          delete "/v1/posts/#{article.id}", headers: auth_tokens
          expect(response.status).to eq 403
        end
      end
    end
    context 'auth_tokensを含まない場合' do
      it '401を返すこと' do
        delete "/v1/posts/#{article.id}"
        expect(response.status).to eq 401
      end
    end
  end
end
