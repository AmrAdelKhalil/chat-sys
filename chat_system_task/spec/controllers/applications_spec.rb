require 'rails_helper'

RSpec.describe ApplicationsController do
  let(:application) {create(:application)}
  let(:application_params) {attributes_for(:application)}

  describe 'POST create' do
    subject {post :create, params: {application: application_params}}
    context 'when new application is inserted' do
      it { is_expected.to have_http_status(:created) }
      it 'no duplicates for applications tokens' do
        post :create, params: {application: application_params}
        first_token = JSON.parse(response.body)['token']
        post :create, params: {application: application_params}
        second_token = JSON.parse(response.body)['token']
        expect(first_token).not_to eq(second_token)
      end
    end
  end

  describe 'PUT update' do
    subject {put :update, params: {token: application.token, application: application_params}}
    context 'when exists application is updated' do
      it {is_expected.to have_http_status(:ok)}
      it 'updates the desc of the application' do
        is_expected
        expect(application.reload.desc).to eq(application_params[:desc])
      end
    end
  end

  describe 'GET show' do
    subject {get :show, params: {token: application.token}}
    context 'when application exists' do
      it{is_expected.to have_http_status(:found)}
      it 'get the correct application' do
        is_expected
        expect(JSON.parse(response.body)['token']).to eq(application.token)
      end
    end
  end
end