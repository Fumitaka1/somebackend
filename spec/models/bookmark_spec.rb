require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:bookmark) { create(:bookmark) }
  describe 'presence' do
    context 'ネームと実在するポストidと実在するユーザーidがある場合' do
      it '投稿できる' do
        expect(bookmark).to be_valid
      end
    end

    context 'ネームが無い場合' do
      it '投稿できない' do
        bookmark.name = ''
        bookmark.valid?
        expect(bookmark.errors.details[:name][0][:error]).to eq :blank
      end
    end

    context 'ポストidが無い場合' do
      it '投稿できない' do
        bookmark.post_id = ''
        bookmark.valid?
        expect(bookmark.errors.details[:post][0][:error]).to eq :blank
      end
    end

    context 'ユーザーidが無い場合' do
      it '投稿できない' do
        bookmark.user_id = ''
        bookmark.valid?
        expect(bookmark.errors.details[:user][0][:error]).to eq :blank
      end
    end
  end

  describe 'length' do
    context 'ネームが100文字の場合' do
      it '投稿できる' do
        bookmark.name = 'a' * 100
        expect(bookmark).to be_valid
      end
    end

    context 'ネームが101文字の場合' do
      it '投稿できない' do
        bookmark.name = 'a' * 101
        bookmark.valid?
        expect(bookmark.errors.details[:name][0][:error]).to eq :too_long
      end
    end
  end
end
