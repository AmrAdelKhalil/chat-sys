require 'rails_helper'

RSpec.describe MessagesController do
  let(:message) {build(:message)}
  let(:chat) {build(:chat_with_messages, messages: [message])}
  let(:application) {create(:application_with_chats, chats: [chat])}
  let(:message_params) {attributes_for(:message)}

  describe 'POST create' do
    let(:chat) { build(:chat) }
    subject {post :create, params: {application_token: application.token, chat_number: chat.chat_number, message: message_params}}
    context 'when new message is inserted' do
      it { is_expected.to have_http_status(:created) }
      it 'no duplicates for messages message_number' do
        post :create, params: {application_token: application.token, chat_number: chat.chat_number, message: message_params}
        first_message_number = JSON.parse(response.body)['message_number']
        post :create, params: {application_token: application.token, chat_number: chat.chat_number, message: message_params}
        second_message_number = JSON.parse(response.body)['message_number']
        expect(first_message_number).not_to eq(second_message_number)
      end
    end
  end

  describe 'PUT update' do
    subject {put :update, params: {application_token: application.token, chat_number: chat.chat_number, number: message.message_number, message: message_params}}
    context 'when exists message is updated' do
      it {is_expected.to have_http_status(:ok)}
      it 'updates the message_number of the message' do
        is_expected
        expect(message.message_number).to eq(JSON.parse(response.body)['message_number'])
      end
    end
  end

  describe 'GET show' do
    subject {get :show, params: {application_token: application.token, chat_number: chat.chat_number, number: message.message_number}}
    context 'when message exists' do
      it{is_expected.to have_http_status(:found)}
      it 'get the correct message' do
        is_expected
        expect(JSON.parse(response.body)['message_number']).to eq(message.message_number)
      end
    end
  end
end