require 'rails_helper'

RSpec.describe ChatsController do
  let(:chat) {build(:chat)}
  let(:application) {create(:application_with_chats, chats: [chat])}
  let(:chat_params) {attributes_for(:chat)}
  let(:message_params) {attributes_for(:message)}

  describe 'POST create' do
    let(:application) { create(:application) }
    subject {post :create, params: {application_token: application.token, chat: chat_params}}
    context 'when new chat is inserted' do
      it { is_expected.to have_http_status(:created)}
      it 'no duplicates for chat chat_number' do
        post :create, params: {application_token: application.token, chat: chat_params}
        first_chat_number = JSON.parse(response.body)['chat_number']
        post :create, params: {application_token: application.token, chat: chat_params}
        second_chat_number = JSON.parse(response.body)['chat_number']
        expect(first_chat_number).not_to eq(second_chat_number)
      end
    end
  end

  describe 'PUT update' do
    subject {put :update, params: {application_token: application.token, number: chat.chat_number, chat: chat_params}}
    context 'when exists chat is updated' do
      it {is_expected.to have_http_status(:ok)}
      it 'updates the chat_number of the chat' do
        is_expected
        expect(chat.chat_number).to eq(JSON.parse(response.body)['chat_number'])
      end
    end
  end

  describe 'GET show' do
    subject {get :show, params: {application_token: application.token, number: chat.chat_number}}
    context 'when chat exists' do
      it{is_expected.to have_http_status(:found)}
    end
  end
end