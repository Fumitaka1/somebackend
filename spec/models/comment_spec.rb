require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }
  describe 'presence' do
    context 'コンテンツと実在するポストidと実在するユーザーidがある場合' do
      it '投稿できる' do
        expect(comment).to be_valid
      end
    end

    context 'コンテンツが無い場合' do
      it '投稿できない' do
        comment.content = ''
        comment.valid?
        expect(comment.errors.details[:content][0][:error]).to eq :blank
      end
    end

    context 'ポストidが無い場合' do
      it '投稿できない' do
        comment.post_id = ''
        comment.valid?
        expect(comment.errors.details[:post][0][:error]).to eq :blank
      end
    end

    context 'ユーザーidが無い場合' do
      it '投稿できない' do
        comment.user_id = ''
        comment.valid?
        expect(comment.errors.details[:user][0][:error]).to eq :blank
      end
    end
  end

  describe 'length' do
    context 'コンテンツが400文字の場合' do
      it '投稿できる' do
        comment.content = 'a' * 400
        expect(comment).to be_valid
      end
    end

    context 'コンテンツが401文字の場合' do
      it '投稿できない' do
        comment.content = 'a' * 401
        comment.valid?
        expect(comment.errors.details[:content][0][:error]).to eq :too_long
      end
    end
  end
end
