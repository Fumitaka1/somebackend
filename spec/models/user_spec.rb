# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  context 'emailとpasswordがある場合' do
    it '登録できる' do
      expect(user).to be_valid
    end
  end

  describe 'presence' do
    context 'emailが無い場合' do
      it '登録できない' do
        user.email = ''
        user.valid?
        expect(user.errors.details[:email][0][:error]).to eq :blank
      end
    end

    context 'passwordが無い場合' do
      it '登録できない' do
        user.password = ''
        user.valid?
        expect(user.errors.details[:password][0][:error]).to eq :blank
      end
    end

    context 'password_confirmationが無い場合' do
      it '登録できない' do
        user.password_confirmation = ''
        user.valid?
        expect(user.errors.details[:password_confirmation][0][:error]).to eq :confirmation
      end
    end
  end

  describe 'uniqueness' do
    context 'emailが重複する場合' do
      it '登録できない' do
        duplicate_user = User.create(email: user.email,
                                  password: 'password',
                                  password_confirmation: 'password')
        duplicate_user.valid?
        expect(duplicate_user.errors.details[:email][0][:error]).to eq :taken
      end
    end
  end

  describe 'format' do
    describe 'email' do
      context 'emailのフォーマットが正しい場合' do
        it '登録できる' do
          valid_addresses = %w[
            example@someone.com
            example@someone.co.jp
            bob.example@some-one.com
            4example@some1.com
          ]
          valid_addresses.each do |valid_address|
            user.email = valid_address
            expect(user).to be_valid
          end
        end
      end
      context 'emailのフォーマットが間違っている場合' do
        it '登録できない' do
          invalid_addresses = %w[
            examplesomeone.com
            example@@someone.co.
            bob.example@some-one..com
            4$example@some1.com
          ]
          invalid_addresses.each do |invalid_address|
            user.email = invalid_address
            user.valid?
            expect(user.errors.details[:email][0][:error]).to eq :invalid
          end
        end
      end
    end
  end

  describe 'length' do
    describe 'email' do
      context 'emailが250文字の場合' do
        it '登録できる' do
          user.email = "#{'a' * 238}@example.com"
          expect(user).to be_valid
        end
      end

      context 'emailが251文字の場合' do
        it '登録できない' do
          user.email = "#{'a' * 239}@example.com"
          user.valid?
          expect(user.errors.details[:email][0][:error]).to eq :too_long
        end
      end
    end

    describe 'password' do
      context 'passwordが6文字の場合' do
        it '登録できる' do
          user.password = user.password_confirmation = 'a' * 6
          expect(user).to be_valid
        end
      end

      context 'passwordが5文字の場合' do
        it '登録できない' do
          user.password = user.password_confirmation = 'a' * 5
          user.valid?
          expect(user.errors.details[:password][0][:error]).to eq :too_short
        end
      end
    end
  end
end
