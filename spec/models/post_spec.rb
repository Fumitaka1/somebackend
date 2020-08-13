# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:sample_post) { create(:post) }
  describe 'presence' do
    context 'コンテンツと実在するユーザーidがある場合' do
      it '投稿できる' do
        expect(sample_post).to be_valid
      end
    end

    context 'コンテンツが無い場合' do
      it '投稿できない' do
        sample_post.content = ''
        sample_post.valid?
        expect(sample_post.errors.details[:content][0][:error]).to eq :blank
      end
    end

    context 'ユーザーidが無い場合' do
      it '投稿できない' do
        sample_post.user_id = ''
        sample_post.valid?
        expect(sample_post.errors.details[:user][0][:error]).to eq :blank
      end
    end
  end

  describe 'length' do
    context 'コンテンツが4,000文字の場合' do
      it '投稿できる' do
        sample_post.content = 'a' * 4_000
        expect(sample_post).to be_valid
      end
    end

    context 'コンテンツが4,001文字の場合' do
      it '投稿できない' do
        sample_post.content = 'a' * 4_001
        sample_post.valid?
        expect(sample_post.errors.details[:content][0][:error]).to eq :too_long
      end
    end
  end
end
